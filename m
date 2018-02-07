Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ejLaW-0001WG-PU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ejLaQ-0001w9-Nf
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:00:20 -0500
Received: from mail-eopbgr10128.outbound.protection.outlook.com
	([40.107.1.128]:38160
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1ejLaQ-0001uz-1I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:00:14 -0500
From: klim <klim.kireev@virtuozzo.com>
References: <20180131162521.31210-1-klim.kireev@virtuozzo.com>
	<20180131164458.GN3255@redhat.com>
	<b7ee30bb-430d-99d1-a417-2aade381cf3c@virtuozzo.com>
Message-ID: <587e1444-efdb-3eaf-f701-3dfc85156aea@virtuozzo.com>
Date: Wed, 7 Feb 2018 12:00:05 +0300
MIME-Version: 1.0
In-Reply-To: <b7ee30bb-430d-99d1-a417-2aade381cf3c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] vnc: fix segfault in closed connection
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On 02/07/2018 11:42 AM, klim wrote:
> On 01/31/2018 07:44 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jan 31, 2018 at 07:25:21PM +0300, Klim Kireev wrote:
>>> On one of our client's node, due to trying to read from closed ioc,
>>> a segmentation fault occured. Corresponding backtrace:
>>>
>>> 0=C2=A0 object_get_class (obj=3Dobj@entry=3D0x0)
>>> 1=C2=A0 qio_channel_readv_full (ioc=3D0x0, iov=3D0x7ffe55277180 ...
>>> 2=C2=A0 qio_channel_read (ioc=3D<optimized out> ...
>>> 3=C2=A0 vnc_client_read_buf (vs=3Dvs@entry=3D0x55625f3c6000, ...
>>> 4=C2=A0 vnc_client_read_plain (vs=3D0x55625f3c6000)
>>> 5=C2=A0 vnc_client_read (vs=3D0x55625f3c6000)
>>> 6=C2=A0 vnc_client_io (ioc=3D<optimized out>, condition=3DG_IO_IN, ...
>>> 7=C2=A0 g_main_dispatch (context=3D0x556251568a50)
>>> 8=C2=A0 g_main_context_dispatch (context=3Dcontext@entry=3D0x556251568a=
50)
>>> 9=C2=A0 glib_pollfds_poll ()
>>> 10 os_host_main_loop_wait (timeout=3D<optimized out>)
>>> 11 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0)
>>> 12 main_loop () at vl.c:1909
>>> 13 main (argc=3D<optimized out>, argv=3D<optimized out>, ...
>>>
>>> Having analyzed the coredump, I understood that the reason is that
>>> ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
>>> in vnc_disconnect_finish. Between these two events due to some
>>> reasons the ioc_tag was set again and after vnc_disconnect_finish
>>> the handler is running with freed ioc,
>>> which led to the segmentation fault.
>>>
>>> The patch checks vs->disconnecting in places where we call
>>> qio_channel_add_watch to prevent such an occurrence.
>>>
>>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>>> ---
>>> Changelog:
>>> v2: Attach the backtrace
>>>
>>> v3: Change checks
>>>
>>> =C2=A0 ui/vnc.c | 18 ++++++++++++++----
>>> =C2=A0 1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/ui/vnc.c b/ui/vnc.c
>>> index 33b087221f..708204fa7e 100644
>>> --- a/ui/vnc.c
>>> +++ b/ui/vnc.c
>>> @@ -1407,13 +1407,19 @@ static void vnc_client_write_locked(VncState=20
>>> *vs)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else
>>> =C2=A0 #endif /* CONFIG_VNC_SASL */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vnc_client_write_plain(vs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vs->disconnecting =3D=
=3D FALSE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vnc=
_client_write_plain(vs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(vs->ioc_tag !=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 g_source_remove(vs->ioc_tag);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vs->ioc_tag =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>> I'm not sure it is safe to only do the check in the else{} branch
>> of this code. If this code is reachable, then I think the SASL
>> branch will cause the same crash problems too.=C2=A0 I think probably
>> need to push the checks up a level or two in the caller stack...
>>
>>> =C2=A0 =C2=A0 static void vnc_client_write(VncState *vs)
>>> =C2=A0 {
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vnc_lock_output(vs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vs->output.offset) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vnc_client_write=
_locked(vs);
>>> @@ -1421,8 +1427,12 @@ static void vnc_client_write(VncState *vs)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vs->ioc_tag)=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_source_remove(vs->ioc_tag);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vs->ioc_tag =3D qio_channel=
_add_watch(
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vs-=
>ioc, G_IO_IN, vnc_client_io, vs, NULL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vs->disconnecting =3D=
=3D FALSE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vs-=
>ioc_tag =3D qio_channel_add_watch(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vs-=
>ioc_tag =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vnc_unlock_output(vs);
>>> =C2=A0 }
>> ...I think perhaps we should do the check in the vnc_client_io()
>> method, and also in the vnc_flush() method.
>>
>> I think we also need to put a check in the vnc_jobs_consume_buffer()
>> method, which can be triggered from a bottom-half.
>
> Thank you for your advice,
> in both places there is a check vs->ioc !=3D NULL, so we don't need=20
> check it there
>

But ioc_tag can be set in those places, so probably you are right and we=20
need to check it there

>>
>> Regards,
>> Daniel
>
>
>
