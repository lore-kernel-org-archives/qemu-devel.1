Received: from eggs.gnu.org ([2001:4830:134:3::10]:54533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWG9l-00056p-KR
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 00:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWG9i-0007bS-Ua
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 00:30:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWG9i-0007bG-MU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 00:30:02 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<d99cf50c824283af2ef2cd79f85b406c7094a321.1485308342.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com>
Date: Wed, 25 Jan 2017 06:29:59 +0100
MIME-Version: 1.0
In-Reply-To: <d99cf50c824283af2ef2cd79f85b406c7094a321.1485308342.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>

On 01/25/17 02:43, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This patch is based off an earlier version by Gal Hammer (ghammer@redhat.com)

(1) This commit msg line is too long; please wrap it at 74 chars.

> 
> Signed-off-by: Gal Hammer <ghammer@redhat.com>
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  docs/specs/vmgenid.txt | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 docs/specs/vmgenid.txt
> 
> diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
> new file mode 100644
> index 0000000..d36ed5b
> --- /dev/null
> +++ b/docs/specs/vmgenid.txt
> @@ -0,0 +1,40 @@
> +VIRTUAL MACHINE GENERATION ID
> +=============================
> +
> +Copyright (C) 2016 Red Hat, Inc.
> +Copyright (C) 2017 Skyport Systems, Inc.
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later.
> +See the COPYING file in the top-level directory.
> +
> +===
> +
> +The VM generation ID (vmgenid) device is an emulated device which
> +exposes a 128-bit, cryptographically random, integer value identifier.
> +This allows management applications (e.g. libvirt) to notify the guest
> +operating system when the virtual machine is executed with a different
> +configuration (e.g. snapshot execution or creation from a template).
> +
> +This is specified on the web at: http://go.microsoft.com/fwlink/?LinkId=260709
> +
> +---
> +
> +The vmgenid device is a sysbus device with the ACPI ID "QEMUGVID".

(2) The ID has a typo, it should be QEMUVGID (see the next patch).

> +
> +The device has one properties,

(3) "property", singular

> which can be set using the command line
> +argument or the QMP interface:
> + guid - sets the value of the GUID.  A special value "auto" instructs
> +        QEMU to generate a new random GUID.
> +For example:
> +QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
> +
> +Or to change guid in runtime use:
> + set-vm-generation-id guid=124e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
> + set-vm-generation-id guid=auto
> +
> +According to the specification, any change to the GUID executes an
> +ACPI notification. The vmgenid device triggers the \_GPE._E05 handler
> +which executes the ACPI Notify operation.
> +
> +Although not specified in Microsoft's document, it is assumed that the
> +device is expected to use the little-endian system.
> 

The above seems okay to me, but it's too terse. Please add an ASCII
diagram (or document in plain text) that describes what object in what
ACPI table points where, what fw_cfg files are used, and so on.
Practically, the entire idea behind patch #4.

I'll try to write more about this in response to patch #4. The goal is
to help QEMU developers understand patch #4 better.

... I have something like this in mind:

https://lists.nongnu.org/archive/html/qemu-devel/2015-09/msg03409.html

(4) I think you could simply steal the "Requirements" section (just
mention in the commit message that that part was originally written up
by me). I think this should be helpful, because we can more easily
validate the implementation against such a bullet list.

(5) For the rest of the document, I suggest a quick skim. Quite a good
chunk will not apply to your implementation (justifiedly!), but it will
explain to you how OVMF behaves in this regard. Plus, it should provide
an example or two for ASCII diagrams.

(If you are interested why that patch series was abandoned ultimately:
it's because Microsoft's ACPI interpreter doesn't support the
DataTableRegion operator, as we found out.
<https://lists.nongnu.org/archive/html/qemu-devel/2015-09/msg03406.html>.)

(6) With regard to OVMF, I'd like to emphasize the "OVMF SDT Header
probe suppressor". (SDT stands for ACPI System Description Table.)

In your implementation, it should be a 40-byte zero-padding at the front
of the fw_cfg blob with the GUID. It is necessary due to how OVMF
processes the ADD_POINTER commands (explained in the linked document).

The gist of it is that OVMF will look for an ACPI table header wherever
an ADD_POINTER command points, therefore 36 bytes -- see the size of
ACPI_TABLE_HEADER_DEF -- should be padded out first, to suppress that
heuristics for the vmgenid GUID. Then 4 more bytes are needed to round
up the start address of the GUID to a multiple of 8.

(7) Another comment related to the fw_cfg file that contains the GUID:
If you check requirement R1e, it follows that the fw_cfg file hosting
the GUID should be placed at a 4KB boundary, and cover a full page.

Therefore the fw_cfg file structure should be like:

- 36 bytes zero padding for suppressing OVMF's SDT Header probe
- 4 bytes zero padding for getting to an 8-byte alignment
- 8 bytes vmgenid GUID
- 4048 bytes zero padding, to ensure that nothing else is allocated on
the same page, either by the firmware or the OS.

The above layout has a consequence for both the ACPI payload you
generate, and for how QEMU acts upon the address written by the
firmware. Namely, the allocation address returned by the firmware will
point to the beginning of the buffer, but both the ADDR method and QEMU
will have to reference the GUID field at offset 40 decimal.

For this, when QEMU writes the new GUID, it will have to add 40 to the
address returned by the firmware.

Plus, the ADDR AML method will have to add 40 to the VGIA field manually.

Illustration (feel free to include it in the document):

+----------------------------------+
| SSDT with OEM Table ID = VMGENID |
+----------------------------------+
| ...                              |       TOP OF PAGE
| VGIA qword object ---------------|-----> +---------------------------+
| ...                              |       | fw-allocated array for    |
| _STA method referring to VGIA    |       | "etc/vmgenid"             |
| ...                              |       +---------------------------+
| ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
| ...                              |       |     suppressor            |
+----------------------------------+       | 36: padding for 8-byte    |
                                           |     alignment             |
                                           | 40: GUID                  |
                                           | 48: padding to page size  |
                                           +---------------------------+
                                           END OF PAGE

When you patch the VGIA object with an ADD_POINTER command, it must
point to the OVMF SDT Header probe suppressor, at offset 0. It is fine
if the _STA method compares VGIA against plain zero, to see in OSPM if
VGIA was indeed patched by the firmware.

However, the ADDR method must add 40 (offset of GUID) to VGIA.
Similarly, QEMU must add 40 to the value received in "etc/vmgenid_addr".

(8) I also suggest including a decompiled dump of the new ACPI payload.
It *really* helps understanding patch #4, whereas currently I
practically have to reverse-engineer patch #4.

Again, I'll try to associate all of these notes with actual code in
patch #4. Still, the documentation should explain them separately.

Thanks
Laszlo
