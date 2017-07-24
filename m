Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dZg4U-0006XB-EC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dZg4T-0005pm-KP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:19:02 -0400
Received: from mail-yw0-x22e.google.com ([2607:f8b0:4002:c05::22e]:35659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dZg4T-0005pS-DD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:19:01 -0400
Received: by mail-yw0-x22e.google.com with SMTP id h189so26704969ywf.2
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 09:19:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724154849.GQ652@quack2.suse.cz>
References: <20170721155848.GO18014@stefanha-x1.localdomain>
	<CAPcyv4gtWYpzbmggsbdLocPiMzU2rVt-ee+kL24gbrPxKd5Eyw@mail.gmail.com>
	<1500818683.4073.31.camel@redhat.com>
	<CAPcyv4h5O4D2kp6SJhWiz4V=dOLDa_Q3pk2B=u-x7hKKQqdXsQ@mail.gmail.com>
	<1500833428.4073.36.camel@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<CAPcyv4g-X8S95=uQBo5MzxpwKfqdTbmBis3B56i59wqWiPnCBA@mail.gmail.com>
	<20170724154849.GQ652@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 24 Jul 2017 09:19:00 -0700
Message-ID: <CAPcyv4iLdcQhDJhi1sh8DT9yW5qSh5ruq-x=bsVTbgzO_NNT4w@mail.gmail.com>
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
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Gupta <pagupta@redhat.com>, Rik van Riel <riel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Mon, Jul 24, 2017 at 8:48 AM, Jan Kara <jack@suse.cz> wrote:
> On Mon 24-07-17 08:10:05, Dan Williams wrote:
>> On Mon, Jul 24, 2017 at 5:37 AM, Jan Kara <jack@suse.cz> wrote:
[..]
>> This approach would turn into a full fsync on the host. The question
>> in my mind is whether there is any optimization to be had by trapping
>> dax_flush() and calling msync() on host ranges, but Jan is right
>> trapping blkdev_issue_flush() and turning around and calling host
>> fsync() is the most straightforward approach that does not need driver
>> interface changes. The dax_flush() approach would need to modify it
>> into a async completion interface.
>
> If the backing device on the host is actually a normal block device or an
> image file, doing full fsync() is the most efficient implementation
> anyway...

Ah, ok, great. That was the gap in my understanding.
