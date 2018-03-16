Received: from eggs.gnu.org ([2001:4830:134:3::10]:49493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewtwS-0001jj-PV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewtwO-0007wK-Io
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:19:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41362
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ewtwO-0007vx-Cw
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:18:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GIFl7d011220
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:18:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2grh8acb83-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:18:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 18:18:53 -0000
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<20180316181953-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 19:18:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180316181953-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <29aa3e9f-ae34-8888-4ec2-2fd22b4d747f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v23 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com



On 03/16/2018 05:27 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 09, 2018 at 06:05:41PM +0100, Halil Pasic wrote:
>>> +\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
>>
>> I can't find what happens if this limit isn't honored by the driver. Moreover
>> reading it is only SHOULD. Is it undefined behavior or should the device reject/fail
>> such requests? I think in qemu implementation we fail the request.
>>
>> This question is only about niceness. We are already good enough, IMHO:
>> since the implementer of the driver can't be sure what is going to happen
>> if the driver disregards max_cipher_key_len it is already an implicit
>> SHOULD.
> 
> I am not sure documenting undefined behaviour is always required.

I kind of agree. But I'm afraid I did not get through my point. It's
about clarity. The driver supplying a cipher key larger that
max_cipher_key_len isn't violating any driver normative statement.
I find it strange make obtaining a piece of configuration a driver
normative but have neither a driver normative that says the driver must
(or should) operate according to the same (at least in certain)
circumstances nor a device normative that implicitly educates the driver
implementer what happens if the driver is acting stupid (see below).


> We certainly do not do this for all other devices> 

"""
5.2.6.2 Device Requirements: Device Operation

A device MUST set the status byte to VIRTIO_BLK_S_IOERR for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT write any data.
"""

I was under the impression, that we sometimes express what is naively
a driver-requirement (e.g. thou shall not write to a read only
device) as a device-requirement. This has benefits in my opinion:
the driver implementer is educated about a certain behavior being a no-no
and hopefully leading to sane error handling (with a compliant device
sitting on the other side) --- instead of  offending drivers landing beyond
the spec (in undefined behavior land) by violating a driver-normative.

> Reading a field being SHOULD seems reasonable: e.g.
> driver might read it once and cache it in memory.

I don't quite understand. Let me quote the normative section

+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
+
+\begin{itemize*}
+\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
+    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
+\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
+\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.

[..]

+\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
+    the device supports.

Does it mean it's OK for the driver (e.g. after a configuration change
notification to use a stale) \field{max_cipher_key_len} ) as it is SHOULD read
bit it's not OK to use a stale \field{max_dataqueues}?

AFAIU all configuration space stuff eligible for caching, but
under certain circumstances the cache invalidates and a re-read
is necessary.

> 
> Halil, could you try to split your comments between requirements
> for more conformance clauses/clarifications as opposed to
> defects where it's wrong and does not match actual or
> expected behaviour?

Yes. I'm already trying to tag my comments. 'This question is only
 about niceness. We are already good enough' was supposed to indicate
that this one is not requirement.

Do you mean putting these in separate emails?

> 
> I think spec is better off with some documentation for this
> device than none at all like today.
> 


If the rest community says it's good enough, I won't fight against
inclusion neither in the repo nor in the next Committee Specification.

I would %100 agree with you if this were normal documentation.
The problem with standards is that both correctness and completeness
are crucial. What is not part of the standard, is not part of the
standard and period.

Virtio is especially tricky as there is no versions of the standard.
What once was a compliant device/driver must be kept compliant when
we change the text. That is why this better something than nothing
does not entirely work for me.

Regards,
Halil
