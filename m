Received: from eggs.gnu.org ([2001:4830:134:3::10]:56772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTVzk-0005zD-0V
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTVzf-0000yc-VH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:20:39 -0400
Received: from chuckie.co.uk ([82.165.15.123]:55425
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTVzf-0000xj-NR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:20:35 -0400
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707164453.4ba325fd@nial.brq.redhat.com>
	<20170707150707.GJ10776@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <58f2d98e-ae7e-e2e7-e7f3-68e937b0b79f@ilande.co.uk>
Date: Fri, 7 Jul 2017 17:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170707150707.GJ10776@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 07/07/17 16:07, Eduardo Habkost wrote:

>> looks fine,
>>
>> so what I'd do is:
>>  * drop 4/6

Yes.

> Agreed on this point.  But:
> 
>>  * make fw_cfg_find() use ambiguous argument and error_abort if ambiguous == true

During my latest tests I've found that everything works fine without the
ambiguous argument.

Do we still want to keep it? And I don't think error_abort() is the
right thing to do here, I'd much rather return NULL and add a suitable
comment.

>>  * from fw_cfg_common_realize() just call
>>
>>      // if fw_cfg_find() returns NULL it means that device isn't in QOM tree
>>      // which shouldn't ever happen, fw_cfg_find() will abort itself if
>>      // another instance of device present in QOM tree.
>>      assert(fw_cfg_find());
> 
> That would work, but I don't see why doing that if just returning
> NULL would: 1) make the code in fw_cfg_find() simpler and
> shorter; 2) make realize error handling friendlier (returning
> error instead of aborting).  We just need to document that
> explicitly in fw_cfg_find() (see find_vmgenid_dev() for an
> example).
> 
> If you still want to make realize abort instead of returning
> error, you don't even need assert(ambiguous) on fw_cfg_find().
> All you need is this on realize:
> 
>    assert(fw_cfg_find() == dev);

I'm definitely not a fan of the assert()...


ATB,

Mark.
