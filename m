Received: from eggs.gnu.org ([2001:4830:134:3::10]:41762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dJ2DA-0005mh-RO
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dJ2D6-00084O-8U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dJ2D6-00083z-1t
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:31:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D01157F09D
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 18:31:06 +0000 (UTC)
References: <20170608161013.17920-1-lersek@redhat.com>
	<961e1ac9-56a5-df24-9ed7-e1981e61942a@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <51ff0ee5-3875-1a51-415c-170a8b3b8eaf@redhat.com>
Date: Thu, 8 Jun 2017 20:31:02 +0200
MIME-Version: 1.0
In-Reply-To: <961e1ac9-56a5-df24-9ed7-e1981e61942a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 06/08/17 18:34, Paolo Bonzini wrote:
> 
> 
> On 08/06/2017 18:10, Laszlo Ersek wrote:
>> When the guest writes value 0xffff to this register, the value that can be
>> read back is that of "mch.extended-tseg-mbytes" -- unless it remains
>> 0xffff. The guest is required to write 0xffff first (as opposed to a
>> read-only register) because PCI config space is generally not cleared on
>> QEMU reset, and after S3 resume or reboot, new guest firmware running on
>> old QEMU could read a guest OS-injected value from this register.
> 
> I guess that's also a reason not to make it readonly (that is, it would
> require some firmware code anyway to test for "readonlyness" and
> distinguish old machine types from new)?

That's right; in
<https://lists.01.org/pipermail/edk2-devel/2017-May/010432.html> I wrote,

> If we invent such a new register, it should be in a location that is
> either read-only, or zeroed-on-reset, in current QEMU. Otherwise, new
> firmware running on old QEMU could be misled by a guest OS that writes
> to this register, and then either reboots or enters S3.
>
> ... With this in mind, I don't oppose "having to write somewhere to
> read back the result", but then let's please make that write access as
> well to the same new qemu-specific register, and not to MCH_ESMRAMC.

The problem is that config space is by default r/w and not cleared on
reboot -- see Gerd's
<https://lists.01.org/pipermail/edk2-devel/2017-May/010456.html> --, and
once we designate another offset as "special" (either "reactive" or
"read only"), the firmware will have to write to it and read it back
unconditionally, to tell it apart from the default / original /
non-special config space.

Thanks!
Laszlo
