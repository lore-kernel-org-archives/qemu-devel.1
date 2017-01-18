Received: from eggs.gnu.org ([2001:4830:134:3::10]:41103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTw3B-0007hM-VK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTw37-0008Te-57
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:37:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cTw36-0008TR-Vo
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:37:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <874m0wqofz.fsf@dusky.pond.sub.org>
	<a1deb000-5e24-89b6-2d39-a1c94cd8b1e8@redhat.com>
Date: Wed, 18 Jan 2017 20:37:33 +0100
In-Reply-To: <a1deb000-5e24-89b6-2d39-a1c94cd8b1e8@redhat.com> (Paolo
	Bonzini's message of "Wed, 18 Jan 2017 18:21:29 +0100")
Message-ID: <8737ggkvlu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] SCSI HBA auto-created for -drive if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/01/2017 18:15, Markus Armbruster wrote:
>> Some boards automatically cold-plug SCSI HBAs to honor -drive if=scsi.
>> Which one depends on the machine:
>> 
>>     pc*, realview-eb*, versatile*: lsi53c895a
>>     spapr-machine: spapr-vscsi
>> 
>> Should we use something less thoroughly obsolete than lsi53c895a for new
>> machine types?  Something that actually has a maintainer?
>
> Or just raise an error?...

On IRC, you remarked "there's no HBA that works reliably for all guest
OSes".

If there's really no sane default, perhaps we shouldn't provide one.

Most machine types don't.  They don't error out, though, they ignore
drives with if=scsi, which leads to an "Orphaned drive without device"
warning, unless the user explicitly configures a suitable SCSI HBA.

Suitable SCSI HBAs are "am53c974", "dc390", "esp", "lsi53c810",
"lsi53c895a", "megasas", "megasas-gen2", "mptsas1068", "spapr-vscsi",
"virtio-scsi-device", but not "pvscsi", "usb-storage", "usb-bot",
"usb-uas".  QEMU is weird.

This automatic creation of frontends for orphaned drives when some
"suitable" device appears is specific to if=scsi.  It isn't done for any
other interface type.  Again, QEMU is weird.

I'd love to ditch this special SCSI magic completely.  But backward
compatibility may compel us to ditch it only for new machine types.
Opinions?
