Received: from eggs.gnu.org ([2001:4830:134:3::10]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTVvs-0003Nb-Et
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTVvo-0007PP-GE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:16:40 -0400
Received: from chuckie.co.uk ([82.165.15.123]:55417
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTVvo-0007P8-8c
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:16:36 -0400
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707132619.GT12152@localhost.localdomain>
	<b3616dc1-2d8e-3cce-cf40-b239d20c1d83@ilande.co.uk>
	<20170707144806.GX12152@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <204ed1c5-c38f-6bca-f5f8-3761f171d473@ilande.co.uk>
Date: Fri, 7 Jul 2017 17:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170707144806.GX12152@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, lersek@redhat.com

On 07/07/17 15:48, Eduardo Habkost wrote:

>>> I don't see what needs to be fixed.  It is not a bug to leave
>>> fw_cfg in /machine/unattached, as long as fw_cfg_find() works
>>> properly.
>>
>> Yeah. I wonder if I've been leading myself astray down the wrong path
>> here? Let me do some more local tests without
>> fw_cfg_unattached_at_realize() and with an ambiguous argument in
>> fw_cfg_find().
> 
> Note that if you add assert(!ambiguous) to fw_cfg_find(), you
> need to choose what to do when multiple devices are instantiated:
> a) Calling fw_cfg_find() on realize, making it abort instead of
>    returning an error;
> b) Not calling fw_cfg_find() on realize, and returning an error
>    using object_resolve_path_type() manually;
> c) Not calling fw_cfg_find(), not returning an error, and letting
>    QEMU abort when fw_cfg_find() is called by other code.
> 
> I think it's simpler to just do like vmgenid does and simply
> return NULL when there are multiple devices.  We just need to
> document that clearly, and be aware of that when calling
> fw_cfg_find() on realize.  But I won't object if you choose
> another option.

Yes, I agree. I should add that I've been testing without the ambiguous
argument and everything seems to be working now...


ATB,

Mark.
