Received: from eggs.gnu.org ([2001:4830:134:3::10]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGheB-0000Ba-5S
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGhe6-0000DQ-Pd
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:09:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dGhe6-0000Cb-GO
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:09:22 -0400
References: <20170531220129.27724-1-aurelien@aurel32.net>
	<20170531220129.27724-31-aurelien@aurel32.net>
	<ea25b082-923d-6c7d-bca3-b4adbd412419@redhat.com>
	<781667e0-740c-8e43-d94b-387092eab0e6@redhat.com>
	<20170601191718.6cftzl5ama4s3es3@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3c65598-59ca-c80e-1f8d-340ab19d902f@redhat.com>
Date: Fri, 2 Jun 2017 10:09:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170601191718.6cftzl5ama4s3es3@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 30/30] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 01.06.2017 21:17, Aurelien Jarno wrote:
> On 2017-06-01 11:04, David Hildenbrand wrote:
>> On 01.06.2017 10:38, David Hildenbrand wrote:
>>> On 01.06.2017 00:01, Aurelien Jarno wrote:
>>>> At the same time fix the TCG version of get_max_cpu_model to return =
the
>>>> maximum model like on KVM. Remove the ETF2 and long-displacement
>>>
>>> I don't understand the part
>>> "fix the TCG version of get_max_cpu_model to return the maximum model
>>> like on KVM".
>>>
>>> Can you elaborate?
>>>
>>>> facilities from the additional features as it is included in the z80=
0.
>>>>
>>>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>>> ---
>>>>  target/s390x/cpu_models.c | 13 ++++++-------
>>>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>> index fc3cb25cc3..c13bbd852c 100644
>>>> --- a/target/s390x/cpu_models.c
>>>> +++ b/target/s390x/cpu_models.c
>>>> @@ -668,8 +668,6 @@ static void add_qemu_cpu_model_features(S390Feat=
Bitmap fbm)
>>>>      static const int feats[] =3D {
>>>>          S390_FEAT_STFLE,
>>>>          S390_FEAT_EXTENDED_IMMEDIATE,
>>>> -        S390_FEAT_EXTENDED_TRANSLATION_2,
>>>> -        S390_FEAT_LONG_DISPLACEMENT,
>>>>          S390_FEAT_LONG_DISPLACEMENT_FAST,
>>>>          S390_FEAT_ETF2_ENH,
>>>>          S390_FEAT_STORE_CLOCK_FAST,
>>>> @@ -696,9 +694,9 @@ static S390CPUModel *get_max_cpu_model(Error **e=
rrp)
>>>>      if (kvm_enabled()) {
>>>>          kvm_s390_get_host_cpu_model(&max_model, errp);
>>>>      } else {
>>>> -        /* TCG emulates a z900 (with some optional additional featu=
res) */
>>>> -        max_model.def =3D &s390_cpu_defs[0];
>>>> -        bitmap_copy(max_model.features, max_model.def->default_feat=
,
>>>> +        /* TCG emulates a z800 (with some optional additional featu=
res) */
>>>> +        max_model.def =3D s390_find_cpu_def(0x2066, 7, 3, NULL);
>>>> +        bitmap_copy(max_model.features, max_model.def->full_feat,
>>>>                      S390_FEAT_MAX);
>>
>> This is most likely wrong: you're indicating features here that are no=
t
>> available on tcg. esp. S390_FEAT_SIE_F2 and friends.
>>
>> I think should only copy the base features and add whatever else is
>> available via add_qemu_cpu_model_features() as already done.
>=20
> The patch series added all the z800 features exposed via STFL/STFLE.
> Indeed the SIE features are missing, but anyway QEMU doesn't emulate SI=
E
> at all so the lack of these features are not exposed to the guest. In t=
hat
> regard QEMU already wrongly claim to emulate a z900.
>=20
>=20
>>>>          add_qemu_cpu_model_features(max_model.features);
>>>>      }
>>>> @@ -956,8 +954,9 @@ static void s390_qemu_cpu_model_initfn(Object *o=
bj)
>>>>      S390CPU *cpu =3D S390_CPU(obj);
>>>> =20
>>>>      cpu->model =3D g_malloc0(sizeof(*cpu->model));
>>>> -    /* TCG emulates a z900 (with some optional additional features)=
 */
>>>> -    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu=
_cpu_defs));
>>>> +    /* TCG emulates a z800 (with some optional additional features)=
 */
>>>> +    memcpy(&s390_qemu_cpu_defs, s390_find_cpu_def(0x2066, 7, 3, NUL=
L),
>>>> +           sizeof(s390_qemu_cpu_defs));
>>>
>>> No changing the qemu model without compatibility handling.
>>>
>> Please have a look at the following mail for a possible solution:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg06030.html
>>
>> This could be moved to a separate patch. So this patch really should
>> just care about the maximum model, not the qemu model.
>=20
> From what I understand from this thread, the patch from Thomas Huth was
> finally considered acceptable. I am adding him in Cc: so that he can
> comment.

In the 2nd version of my patch, I only changed the full_feat of the
model definitions, but not the base_feat and default_feat fields, so
that the CPU stays the same when you run QEMU without "-cpu" parameter
(or simply with "-cpu qemu").

Consider that the following scenario should work: Start a QEMU v2.10
with "-M s390-ccw-virtio-2.9" and a QEMU v2.9 with "-M
s390-ccw-virtio-2.9 -incoming ...". Then it should be possible to
migrate from the v2.10 to the v2.9 instance without problems. This won't
work anymore if you changed the default feature bits unconditionally.

 Thomas
