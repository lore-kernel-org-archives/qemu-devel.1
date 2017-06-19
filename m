Received: from eggs.gnu.org ([2001:4830:134:3::10]:44217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dN1kQ-0005HD-PA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dN1kM-0003H0-Sd
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:50:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34125
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dN1kM-0003Fh-LN
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:49:58 -0400
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
Date: Mon, 19 Jun 2017 19:49:40 +0100
MIME-Version: 1.0
In-Reply-To: <08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On 19/06/17 18:09, Laszlo Ersek wrote:

>> What seems to happen is that calling object_property_add_child() only
>> succeeds for the first instance and so a simple comparison is enough to
>> determine that the device already exists at FW_CFG_PATH. Or is this a
>> fairly terrible (ab)use of the QOM APIs?
> 
> This has jogged my memory about how we ensure "at most one" for the
> vmgenid device. Please see:
> 
>   vmgenid_realize()    [hw/acpi/vmgenid.c]
>     find_vmgenid_dev() [include/hw/acpi/vmgenid.h]
> 
> ... I was quite silly not to think of this on my own now, despite having
> authored commit f92063028a0e ("hw/acpi/vmgenid: prevent more than one
> vmgenid device", 2017-03-20) :/

Right that definitely helps - the following code seems to work correctly
when trying to instantiate a mixture of fw_cfg_io and/or fw_cfg_mem types:

if (!object_resolve_path_type("", TYPE_FW_CFG, NULL)) {
    error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);
    return;
}

I've also copied the wording from the above commit to make everything
consistent. Does that seem okay? If so, I'll fold it into a v7 patchset.


ATB,

Mark.
