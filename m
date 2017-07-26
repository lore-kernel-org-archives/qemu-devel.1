Received: from eggs.gnu.org ([2001:4830:134:3::10]:42259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1daU2u-00052O-Gh
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1daU2t-0006lD-QU
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:44 -0400
Received: from mail-yw0-x235.google.com ([2607:f8b0:4002:c05::235]:36449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1daU2t-0006gY-Hv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:43 -0400
Received: by mail-yw0-x235.google.com with SMTP id u207so34376225ywc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:40:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501104453.26846.45.camel@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
	<1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
	<1501104453.26846.45.camel@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Jul 2017 14:40:36 -0700
Message-ID: <CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Wed, Jul 26, 2017 at 2:27 PM, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 2017-07-26 at 09:47 -0400, Pankaj Gupta wrote:
>> >
>> Just want to summarize here(high level):
>>
>> This will require implementing new 'virtio-pmem' device which
>> presents
>> a DAX address range(like pmem) to guest with read/write(direct
>> access)
>> & device flush functionality. Also, qemu should implement
>> corresponding
>> support for flush using virtio.
>>
> Alternatively, the existing pmem code, with
> a flush-only block device on the side, which
> is somehow associated with the pmem device.
>
> I wonder which alternative leads to the least
> code duplication, and the least maintenance
> hassle going forward.

I'd much prefer to have another driver. I.e. a driver that refactors
out some common pmem details into a shared object and can attach to
ND_DEVICE_NAMESPACE_{IO,PMEM}. A control device on the side seems like
a recipe for confusion.

With a $new_driver in hand you can just do:

   modprobe $new_driver
   echo $namespace > /sys/bus/nd/drivers/nd_pmem/unbind
   echo $namespace > /sys/bus/nd/drivers/$new_driver/new_id
   echo $namespace > /sys/bus/nd/drivers/$new_driver/bind

...and the guest can arrange for $new_driver to be the default, so you
don't need to do those steps each boot of the VM, by doing:

    echo "blacklist nd_pmem" > /etc/modprobe.d/virt-dax-flush.conf
    echo "alias nd:t4* $new_driver" >> /etc/modprobe.d/virt-dax-flush.conf
    echo "alias nd:t5* $new_driver" >> /etc/modprobe.d/virt-dax-flush.conf
