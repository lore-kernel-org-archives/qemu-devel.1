Received: from eggs.gnu.org ([2001:4830:134:3::10]:44398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eoFRx-0000jw-7o
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eoFRs-0005e1-AK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:27:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1eoFRs-0005dH-5t
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:27:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5997A404085A
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 21:27:28 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
References: <20180220152843.26464-1-kraxel@redhat.com>
	<20180220152843.26464-5-kraxel@redhat.com>
	<869a9977-cc4d-1638-53f7-5966f6e3be52@redhat.com>
Date: Tue, 20 Feb 2018 16:27:21 -0500
In-Reply-To: <869a9977-cc4d-1638-53f7-5966f6e3be52@redhat.com> (Eric Blake's
	message of "Tue, 20 Feb 2018 14:47:33 -0600")
Message-ID: <jpgtvub9wsm.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/5] usb-mtp: Introduce write support for
 MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/20/2018 09:28 AM, Gerd Hoffmann wrote:
>> From: Bandan Das <bsd@redhat.com>
>>
>> Allow write operations on behalf of the initiator. The
>> precursor to write is the sending of the write metadata
>> that consists of the ObjectInfo dataset. This patch introduces
>> a flag that is set when the responder is ready to receive
>> write data based on a previous SendObjectInfo operation by
>> the initiator (The SendObjectInfo implementation is in a
>> later patch)
>>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> Message-id: 20180215231129.14710-5-bsd@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   hw/usb/dev-mtp.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>   1 file changed, 157 insertions(+), 2 deletions(-)
>>
>
>> @@ -1472,12 +1492,133 @@ static void usb_mtp_cancel_packet(USBDevice *de=
v, USBPacket *p)
>>       fprintf(stderr, "%s\n", __func__);
>>   }
>>   +mode_t getumask(void)
>> +{
>> +    mode_t mask =3D umask(0);
>> +    umask(mask);
>> +    return mask;
>> +}
>
> This is dangerous.  'man getumask' on my Fedora machine states:

Thanks for the pointer, Eric. Indeed, this doesn't look right.
I am inclined to just set the default
permission of created files to 0644 for the mtp share
and not implement a thread safe getumask.

Bandan

> CONFORMING TO
>        This is a vaporware GNU extension.
>
> NOTES
>        This  function is documented in the glibc manual, but, as at
> glibc ver=E2=80=90
>        sion 2.24, it is not implemented on Linux.  (See umask(2) for a
> thread-
>        safe method of discovering a process's umask.)
>
>
> and 'man 2 umask' concurs:
>
>        It  is  impossible to use umask() to fetch a process's umask
> without at
>        the same time changing it.  A second call  to  umask()  would
> then  be
>        needed  to restore the umask.  The nonatomicity of these two
> steps pro=E2=80=90
>        vides the potential for races in multithreaded programs.
>
> It is ONLY safe to grab umask() prior to spawning threads, cache that
> value, and refer to the cache at all later points.
