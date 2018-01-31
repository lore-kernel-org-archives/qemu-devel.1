Received: from eggs.gnu.org ([2001:4830:134:3::10]:56131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1egsHn-0005OD-I6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1egsHh-0002yh-Hy
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:18:47 -0500
Received: from mail-db5eur01on0116.outbound.protection.outlook.com
	([104.47.2.116]:30108
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1egsHh-0002xj-6w
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:18:41 -0500
References: <20180131130613.30959-1-klim.kireev@virtuozzo.com>
	<CAJ+F1C+PL8W1GosN2qrgwGRJ+kTc4nur9oZe3QCUqNqBszX6Eg@mail.gmail.com>
From: klim <klim.kireev@virtuozzo.com>
Message-ID: <efee16ba-e900-03ff-7e72-3edc6f97057b@virtuozzo.com>
Date: Wed, 31 Jan 2018 16:18:33 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+PL8W1GosN2qrgwGRJ+kTc4nur9oZe3QCUqNqBszX6Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] vnc: fix segfault in closed connection
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 01/31/2018 04:16 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Jan 31, 2018 at 2:06 PM, Klim Kireev <klim.kireev@virtuozzo.com> =
wrote:
>> On one of our client's node, due to trying to read from closed ioc,
>> a segmentation fault occured. Corresponding backtrace:
>>
> Oops, you probably forgot an extra space before the # interpreted as comm=
ent.
Thanks, fixed
>
> Do you have a reproducer?
Unfortunately, no
>> Having analyzed the coredump, I understood that the reason is that
>> ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
>> in vnc_disconnect_finish. Between these two events due to some
>> reasons the ioc_tag was set again and after vnc_disconnect_finish
>> the handler is running with freed ioc,
>> which led to the segmentation fault.
>>
>> I suggest to check ioc_tag in vnc_disconnect_finish to prevent such
>> an occurrence.
>
>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>> ---
>>   ui/vnc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 33b087221f..b8bf0180cb 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -1270,6 +1270,10 @@ void vnc_disconnect_finish(VncState *vs)
>>       }
>>       g_free(vs->lossy_rect);
>>
>> +    if (vs->ioc_tag) {
>> +        g_source_remove(vs->ioc_tag);
>> +        vs->ioc_tag =3D 0;
>> +    }
>>       object_unref(OBJECT(vs->ioc));
>>       vs->ioc =3D NULL;
>>       object_unref(OBJECT(vs->sioc));
>> --
>> 2.14.3
>>
>>
>
>
