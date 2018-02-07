Received: from eggs.gnu.org ([2001:4830:134:3::10]:53600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ejLJF-0000LH-I3
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 03:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ejLJA-00049A-T1
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 03:42:28 -0500
Received: from mail-ve1eur01on0119.outbound.protection.outlook.com
	([104.47.1.119]:11164
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1ejLJA-000480-C9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 03:42:24 -0500
References: <20180131162521.31210-1-klim.kireev@virtuozzo.com>
	<20180131164458.GN3255@redhat.com>
From: klim <klim.kireev@virtuozzo.com>
Message-ID: <b7ee30bb-430d-99d1-a417-2aade381cf3c@virtuozzo.com>
Date: Wed, 7 Feb 2018 11:42:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180131164458.GN3255@redhat.com>
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

On 01/31/2018 07:44 PM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 31, 2018 at 07:25:21PM +0300, Klim Kireev wrote:
>> On one of our client's node, due to trying to read from closed ioc,
>> a segmentation fault occured. Corresponding backtrace:
>>
>> 0  object_get_class (obj=3Dobj@entry=3D0x0)
>> 1  qio_channel_readv_full (ioc=3D0x0, iov=3D0x7ffe55277180 ...
>> 2  qio_channel_read (ioc=3D<optimized out> ...
>> 3  vnc_client_read_buf (vs=3Dvs@entry=3D0x55625f3c6000, ...
>> 4  vnc_client_read_plain (vs=3D0x55625f3c6000)
>> 5  vnc_client_read (vs=3D0x55625f3c6000)
>> 6  vnc_client_io (ioc=3D<optimized out>, condition=3DG_IO_IN, ...
>> 7  g_main_dispatch (context=3D0x556251568a50)
>> 8  g_main_context_dispatch (context=3Dcontext@entry=3D0x556251568a50)
>> 9  glib_pollfds_poll ()
>> 10 os_host_main_loop_wait (timeout=3D<optimized out>)
>> 11 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0)
>> 12 main_loop () at vl.c:1909
>> 13 main (argc=3D<optimized out>, argv=3D<optimized out>, ...
>>
>> Having analyzed the coredump, I understood that the reason is that
>> ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
>> in vnc_disconnect_finish. Between these two events due to some
>> reasons the ioc_tag was set again and after vnc_disconnect_finish
>> the handler is running with freed ioc,
>> which led to the segmentation fault.
>>
>> The patch checks vs->disconnecting in places where we call
>> qio_channel_add_watch to prevent such an occurrence.
>>
>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>> ---
>> Changelog:
>> v2: Attach the backtrace
>>
>> v3: Change checks
>>
>>   ui/vnc.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 33b087221f..708204fa7e 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -1407,13 +1407,19 @@ static void vnc_client_write_locked(VncState *vs=
)
>>       } else
>>   #endif /* CONFIG_VNC_SASL */
>>       {
>> -        vnc_client_write_plain(vs);
>> +        if (vs->disconnecting =3D=3D FALSE) {
>> +            vnc_client_write_plain(vs);
>> +        } else {
>> +            if (vs->ioc_tag !=3D 0) {
>> +                g_source_remove(vs->ioc_tag);
>> +                vs->ioc_tag =3D 0;
>> +            }
>> +        }
>>       }
>>   }
> I'm not sure it is safe to only do the check in the else{} branch
> of this code. If this code is reachable, then I think the SASL
> branch will cause the same crash problems too.  I think probably
> need to push the checks up a level or two in the caller stack...
>
>>  =20
>>   static void vnc_client_write(VncState *vs)
>>   {
>> -
>>       vnc_lock_output(vs);
>>       if (vs->output.offset) {
>>           vnc_client_write_locked(vs);
>> @@ -1421,8 +1427,12 @@ static void vnc_client_write(VncState *vs)
>>           if (vs->ioc_tag) {
>>               g_source_remove(vs->ioc_tag);
>>           }
>> -        vs->ioc_tag =3D qio_channel_add_watch(
>> -            vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
>> +        if (vs->disconnecting =3D=3D FALSE) {
>> +            vs->ioc_tag =3D qio_channel_add_watch(
>> +                vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
>> +        } else {
>> +            vs->ioc_tag =3D 0;
>> +        }
>>       }
>>       vnc_unlock_output(vs);
>>   }
> ...I think perhaps we should do the check in the vnc_client_io()
> method, and also in the vnc_flush() method.
>
> I think we also need to put a check in the vnc_jobs_consume_buffer()
> method, which can be triggered from a bottom-half.

Thank you for your advice,
in both places there is a check vs->ioc !=3D NULL, so we don't need check=20
it there

>
> Regards,
> Daniel
