Received: from eggs.gnu.org ([209.51.188.92]:49321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIuTn-0002IJ-Mg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIuH6-0002va-NO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:11:49 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
Date: Tue, 23 Apr 2019 14:11:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 18.04.19 13:31, Christian Borntraeger wrote:
> Adding generation 15.
>=20
> Some interesting aspects:
> - conditional SSKE and bpb are deprecated. This patch set addresses tha=
t
>   for csske.
> - no name yet for gen15, I suggest to use the assigned numbers and
>   provide an alias later on. (I have split out this into a separate
>   patch)
>=20
> Christian Borntraeger (10):
>   linux header sync
>   s390x/cpumodel: remove CSSKE from base model
>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
>   s390x/cpumodel: msa9 facility
>   s390x/cpumodel: vector enhancements
>   s390x/cpumodel: enhanced sort facility
>   s390x/cpumodel: deflate
>   s390x/cpumodel: add gen15 defintions
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>   s390x/cpumodel: do not claim csske for expanded models in qmp
>=20
>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>  linux-headers/asm-s390/kvm.h    |  5 +-
>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>  target/s390x/cpu_features.h     |  3 ++
>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>  target/s390x/cpu_models.c       | 35 ++++++++++++
>  target/s390x/cpu_models.h       |  1 +
>  target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++++++++++-
>  target/s390x/kvm.c              | 18 +++++++
>  9 files changed, 263 insertions(+), 2 deletions(-)
>=20

I guess to handle deprecation of CSSKE:

1. Remove it from the base + default model of the gen15, keep it in the
max model. This is completely done in target/s390x/gen-features.c.
Existing base models are not modified.

2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g. z14
will work. We can backport this to distros/stable.


CPU model expansion:

cpu_info_from_model() should already properly be based on the base
features. "gen15" vs. "gen15,csske=3Don" should be automatically generate=
d
when expanding.

CPU model baseline:

s390_find_cpu_def() should make sure that CSSKE is basically ignored
when determining maximum model, however it will properly be indicated if
both models had the feature.

CPU model comparison:

Should work as expected. Availability of CSSKE will be considered when
calculating the result.

gen14,csske=3Don and gen15,csske=3Doff will result in
CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.

gen14,csske=3Doff and gen15,csske=3Doff should result in
CPU_MODEL_COMPARE_RESULT_SUBSET

gen14,csske=3Don and gen15,csske=3Don should result in
CPU_MODEL_COMPARE_RESULT_SUBSET

Forward migration:

Now, the only issue is when csske is actually turned of in future
machines. We would e.g. have

gen15,csske=3Don and gen16,csske=3Doff

While baselining will work correctly (gen15,csske=3Doff), forward
migration is broken (comparison will properly indicate
CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when ripping
out features. Same applies to BPB.


Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
expanded models in qmp" tried to address this, however I am not really
happy with this approach. We should not play such tricks when expanding
the host model. "-cpu host" and "-cpu $expanded_host" would be
different, that is really confusing, especially think about baselining
or comparing against "host", where your patch does not apply..


Whenever users would specify "-cpu gen15", everything would be fine in
regards to forward migration. Maybe clients really have to be taught
about upcoming forward migration issues. "Don't use the host model, make
sure bpa and csske are disabled".

--=20

Thanks,

David / dhildenb
