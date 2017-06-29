Received: from eggs.gnu.org ([2001:4830:134:3::10]:43840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQTW2-000284-9L
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQTVz-0007CX-5L
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQTVy-0007CA-V0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:05:23 -0400
References: <20170627161032.5014-1-david@redhat.com>
	<251b8047-7df4-50a5-cce7-b66858c781a1@redhat.com>
	<4c7a78bc-ec7f-9873-0bda-f3c8e76c844b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3373125e-171a-0516-90f0-757d60eba32a@redhat.com>
Date: Thu, 29 Jun 2017 09:05:16 +0200
MIME-Version: 1.0
In-Reply-To: <4c7a78bc-ec7f-9873-0bda-f3c8e76c844b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: allow to enable "idtes"
 feature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>

On 28.06.2017 19:02, David Hildenbrand wrote:
> On 28.06.2017 16:21, Thomas Huth wrote:
>> On 27.06.2017 18:10, David Hildenbrand wrote:
>>> STFL bit 4 and 5 are just indications to the guest, which TLB entries=
 an
>>> IDTE call will clear. These are performance indicators for the guest.
>>>
>>> STFL bit 4:
>>>     INVALIDATE DAT TABLE ENTRY (IDTE) performs
>>>     the invalidation-and-clearing operation by
>>>     selectively clearing TLB segment-table entries
>>>     when a segment-table entry or entries are
>>>     invalidated. IDTE also performs the clearing-by-
>>>     ASCE operation. Unless bit 4 is one, IDTE simply
>>>     purges all TLBs. Bit 3 is one if bit 4 is one.
>>>
>>> We can simply set STFL bit 4 ("idtes") and still purge the complete T=
LB.
>>> Purging more than advertised is never bad. E.g. Linux doesn't even ca=
re
>>> about this bit. We can optimized this later.
>>
>> Not sure, but why do we need this bit in add_qemu_cpu_model_features()
>> if Linux does not care about it? We will get it automatically once we
>> support the z9 in TCG...
>=20
> The idea is to use this as a list we support in addition to the z900
> features. This is later helpful when actually switching to a new model
> (z9 might still take some time). Nobody has to do go over all features
> again and see if they are implemented.

OK, I agree, that makes sense.

However, I'm not sure whether you can simply ignore the clearing-by-ASCE
stuff in this case. For example, according to the PoP:

"When the clearing-by-ASCE-option bit (bit 52 of gen-
 eral register R2 is one), the M4 field is ignored."

And the idte helper function currently always takes the M4 field into
account...

 Thomas
