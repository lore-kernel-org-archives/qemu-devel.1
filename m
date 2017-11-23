Received: from eggs.gnu.org ([2001:4830:134:3::10]:54630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eHnQv-0006Ik-8n
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eHnQp-000697-7o
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:04:33 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
	<97df2225-908c-e817-8364-2454f1451768@redhat.com>
	<1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
	<efa75e61-f1f7-478f-b5b5-ab39491761e2@redhat.com>
	<20171121174202.GD11073@localhost.localdomain>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <4c1a13c9-e5e5-b61f-76c2-ecb284a08349@virtuozzo.com>
Date: Thu, 23 Nov 2017 12:04:11 +0300
MIME-Version: 1.0
In-Reply-To: <20171121174202.GD11073@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Pavel Butsykin <pbutsykin@virtuozzo.com>



On 21/11/2017 8:42 PM, Kevin Wolf wrote:
> Am 15.11.2017 um 17:30 hat Max Reitz geschrieben:
>> On 2017-11-15 17:28, Anton Nefedov wrote:
>>> On 15/11/2017 6:11 PM, Max Reitz wrote:
>>>> On 2017-11-14 11:16, Anton Nefedov wrote:
>>>>> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>>>>
>>>>> At the moment, qcow2_co_pwritev_compressed can process the requests s=
ize
>>>>> less than or equal to one cluster. This patch added possibility to wr=
ite
>>>>> compressed data in the QCOW2 more than one cluster. The implementatio=
n
>>>>> is simple, we just split large requests into separate clusters and wr=
ite
>>>>> using existing functionality. For unaligned requests we use a workaro=
und
>>>>> and do write data without compression.
>>>>>
>>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>>> ---
>>>>>  =A0 block/qcow2.c | 77
>>>>> +++++++++++++++++++++++++++++++++++++++++++----------------
>>>>>  =A0 1 file changed, 56 insertions(+), 21 deletions(-)
>>>>
>>>> On one hand, it might be better to do this centrally somewhere in
>>>> block/io.c.=A0 On the other, that would require more work because it w=
ould
>>>> probably mean having to introduce another field in BlockLimits, and it
>>>> wouldn't do much -- because qcow (v1) is, well, qcow v1...=A0 And vmdk
>>>> seems to completely not care about this single cluster limitation.=A0 =
So
>>>> for now we probably wouldn't even gain anything by doing this in
>>>> block/io.c.
>>>>
>>>> So long story short, it's OK to do this locally in qcow2, yes.
>>>>
>>>
>>> [..]
>>>
>>>>> +=A0=A0=A0=A0=A0=A0=A0 qemu_iovec_reset(&hd_qiov);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 chunk_size =3D MIN(bytes, s->cluster_size);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 qemu_iovec_concat(&hd_qiov, qiov, curr_off, ch=
unk_size);
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D qcow2_co_pwritev_cluster_compressed(bs=
, offset +
>>>>> curr_off,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 chunk_size,
>>>>> &hd_qiov);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D -ENOTSUP) {
>>>>
>>>> Why this?=A0 I mean, I can see the appeal, but then we should probably
>>>> actually return -ENOTSUP somewhere (e.g. for unaligned clusters and th=
e
>>>> like) -- and we should not abort if offset_into_cluster(s, cluster) is
>>>> true, but we should write the header uncompressed and compress the mai=
n
>>>> bulk.
>>>>
>>>> Max
>>>>
>>>
>>> Right, sorry, missed this part when porting the patch.
>>>
>>> I think this needs to be removed (and the commit message fixed
>>> accordingly).
>>> Returning an error, rather than silently falling back to uncompressed
>>> seems preferable to me. "Compressing writers" (backup, img convert and
>>> now stream) are aware that they have to cluster-align, and if they fail
>>> to do so that means there is an error somewhere.
>>
>> OK for me.
>>
>>> If it won't return an error anymore, then the unaligned tail shouldn't
>>> either. So we can end up 'letting' the callers send small unaligned
>>> requests which will never get compressed.
>>
>> Either way is fine.  It just looks to me like vmdk falls back to
>> uncompressed writes, so it's not like it would be completely new behavio=
r...
>>
>> (But I won't judge whether what vmdk does is a good idea.)
>=20
> Probably not.
>=20
> If we let io.c know about the cluster-size alignment requirement for
> compressed writes, the usual RMW code path could kick in. Wouldn't this
> actually be a better solution than uncompressed writes or erroring out?
>=20
> In fact, with this, we might even be very close to an option that turns
> every write into a compressed write, so you get images that stay
> compressed even while they are in use.
>=20
> Kevin
>=20

That's alignment, and indeed it would be nice to have that block limit
and I think this patch does not contradict with that (now that in v2 it
doesn't fall back to uncompressed but returns EINVAL).
Unless we also want a max request limit so io.c does the request split?

/Anton
