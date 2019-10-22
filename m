Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13384CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61992075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eICyS+Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61992075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsPO-0005j7-Tp
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMsNp-0004Ri-C4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMsNm-0004y0-U7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:31:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMsNm-0004xO-OJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571743881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HnPyeR2vqKEpSRtReB454uLrxdgPmUfsiihUOydoSyY=;
 b=eICyS+PjkmkKQHynK2rK3CKxHO4kJma+vOZ9j/QPYPAwHZaep0u/yFgQ4n6+ORCZVbMpKm
 cktFKHsUT63vkmgBwY6DttXm7zODfWSd/ViGlPRYrDlUblNrZoN/CT4zdmae2IgURraGiZ
 qpk2dTDiOXqMz/WFCOGuxaI8kJm+Jo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-IersrsR-Pumpu9oUwzGssg-1; Tue, 22 Oct 2019 07:31:14 -0400
X-MC-Unique: IersrsR-Pumpu9oUwzGssg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC2C1800DFA;
 Tue, 22 Oct 2019 11:31:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8E7060161;
 Tue, 22 Oct 2019 11:31:08 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
 <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
 <cc3f87c2-3ad5-da4e-4750-27a48bce1ee6@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <787da788-9aca-2110-a092-b63ef498a9fa@redhat.com>
Date: Tue, 22 Oct 2019 13:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cc3f87c2-3ad5-da4e-4750-27a48bce1ee6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gWzTNzs3fTcBwvKluYrzQ3vCI04jfEH27"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gWzTNzs3fTcBwvKluYrzQ3vCI04jfEH27
Content-Type: multipart/mixed; boundary="0ntlWQojfiabiKVugCSuF331LVIvB3f4H"

--0ntlWQojfiabiKVugCSuF331LVIvB3f4H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.10.19 12:46, Vladimir Sementsov-Ogievskiy wrote:
> 22.10.2019 13:21, Andrey Shinkevich wrote:
>>
>> On 22/10/2019 12:28, Max Reitz wrote:
>>> On 20.10.19 22:37, Andrey Shinkevich wrote:
>>>> To inform the block layer about writing all the data compressed, we
>>>> introduce the 'compress' command line option. Based on that option, th=
e
>>>> written data will be aligned by the cluster size at the generic layer.
>>>>
>>>> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block.c                   | 20 +++++++++++++++++++-
>>>>    block/io.c                | 13 +++++++++----
>>>>    block/qcow2.c             |  4 ++++
>>>>    blockdev.c                |  9 ++++++++-
>>>>    include/block/block.h     |  1 +
>>>>    include/block/block_int.h |  2 ++
>>>>    qapi/block-core.json      |  5 ++++-
>>>>    qemu-options.hx           |  6 ++++--
>>>>    8 files changed, 51 insertions(+), 9 deletions(-)
>>>
>>> The problem with compression is that there are such tight constraints o=
n
>>> it that it can really only work for very defined use cases.  Those
>>> constraints are:
>>>
>>> - Only write whole clusters,
>>> - Clusters can be written to only once.
>>>
>>> The first point is addressed in this patch by setting request_alignment=
.
>>>    But I don=E2=80=99t see how the second one can be addressed.  Well, =
maybe by
>>> allowing it in all drivers that support compression.  But if I just loo=
k
>>> at qcow2, that isn=E2=80=99t going to be trivial: You need to allocate =
a
>>> completely new cluster where you write the data (in case it grows), and
>>> thus you leave behind a hole, which kind of defeats the purpose of
>>> compression.
>>>
>>> (For demonstration:
>>>
>>> $ ./qemu-img create -f qcow2 test.qcow2 64M
>>> Formatting 'test.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D655=
36
>>> lazy_refcounts=3Doff refcount_bits=3D16
>>> $ x86_64-softmmu/qemu-system-x86_64 \
>>>       -blockdev "{'node-name': 'drv0', 'driver': 'qcow2',
>>>                   'compress': true,
>>>                   'file': {'driver': 'file', 'filename': 'test.qcow2'}}=
" \
>>>       -monitor stdio
>>> QEMU 4.1.50 monitor - type 'help' for more information
>>> (qemu) qemu-io drv0 "write -P 42 0 64k"
>>> wrote 65536/65536 bytes at offset 0
>>> 64 KiB, 1 ops; 00.02 sec (4.055 MiB/sec and 64.8793 ops/sec)
>>> (qemu) qemu-io drv0 "write -P 23 0 64k"
>>> write failed: Input/output error
>>>
>>> )
>>>
>>> Compression really only works when you fully write all of an image
>>> exactly once; i.e. as the qemu-img convert or as a backup target.  For
>>> both cases we already have a compression option.  So I=E2=80=99m wonder=
ing where
>>> this new option is really useful.
>>>
>>> (You do add a test for stream, but I don=E2=80=99t know whether that=E2=
=80=99s really a
>>> good example, see my response there.)
>>>
>>> Max
>>>
>>
>> Thank you very much Max for your detailed response.
>>
>> 1) You are right that compression is used with the backup mostly. The
>> option for the compression with backup would be replaced by usage at the
>> block layer, with no duplication. Also, it can be useful for NBD for
>> instance,
>>
>> $ ./qemu-img create -f qcow2 -o size=3D10G ./image.qcow2
>> $ sudo ./qemu-nbd -c /dev/nbd0 ./image.qcow2
>> $ sudo dd if=3D/dev/sda1 of=3D/dev/nbd0 bs=3D10M count=3D10
>> 10+0 records in
>> 10+0 records out
>> 104857600 bytes (105 MB) copied, 0,0890581 s, 1,2 GB/s
>> $ sudo ./qemu-nbd -d /dev/nbd0
>> $ du -sh ./image.qcow2
>> 101M    ./image.qcow2
>>
>> and with the compression
>>
>> $ ./qemu-img create -f qcow2 -o size=3D10G ./image.qcow2
>> $ sudo ./qemu-nbd -C -c /dev/nbd0 ./image.qcow2
>> $ sudo dd if=3D/dev/sda1 of=3D/dev/nbd0 bs=3D10M count=3D10
>> 10+0 records in
>> 10+0 records out
>> 104857600 bytes (105 MB) copied, 0,076046 s, 1,4 GB/s
>> $ sudo ./qemu-nbd -d /dev/nbd0
>> $ du -sh ./image.qcow2
>> 5,3M    ./image.qcow2

That seems wrong to me.  Why not use qemu-img convert for this case?

Attaching an NBD server to a compressed disk has exactly the same
problem as attaching a compressed disk to a VM.  It won=E2=80=99t work unle=
ss
the client/guest is aware of the limitations.

>> The idea behind introducing the new 'compress' option is to use that
>> only one instead of many other ones of such a kind.
>>
>> 2) You are right also that "Compression can't overwrite anything..."
>> It can be seen in the commit message
>> b0b6862e5e1a1394e0ab3d5da94ba8b0da8664e2
>>
>> I am not sure if data should be written compressed to the active layer.
>> I made the tests with the idea of bringing examples of usage the
>> 'compress' option because passing an option is a tricky thing in QEMU.
>> But the issue takes place anyway if we want to rewrite to allocated
>> clusters.
>> I would like to investigate the matter and make a patch that resolves
>> that issue.
>> Do you agree with that?

What seems wrong to me is that this series just adds a generic compress
option without ensuring that it works generically.

Either (1) it only works in well-defined cases, then either (1A) we have
to ensure that we only allow it then (as we do now, because only
qemu-img convert and the backup job have such an option; and those two
are safe), or (1B) we have to clearly give a big warning for the new
option that it doesn=E2=80=99t work correctly.  I don=E2=80=99t know whethe=
r such a
warning is even possible with just a generic node-level option.

Or (2) we make it work in generic cases.  Well, that might be possible
for qcow2, but who=E2=80=99s going to make it work for VMDK=E2=80=99s strea=
mOptimized
subformat?

More on all of that below.

> Yes, we want this option not to allow compressed writes for guests, but t=
o
> allow
> - stream with compression (used to remove compressed incremental backup, =
we
> need to merge it to the next incremental)

Based on the assumption that one shouldn=E2=80=99t attach a compressed disk=
 to a
VM, I don=E2=80=99t see how streaming makes sense then.  Well, I suppose
intermediate streaming would work.

> - backup with compression (we have an optional already, so it works)
> - backup to nbd server with compression: enable compression on nbd server

The problem is clearly that if a generic client were to connect to the
NBD server, it wouldn=E2=80=99t work.  In this case, compression will work =
only
if the clients understands the limitation.

(The safe way would be to make the NBD server provide an option that
clients can see so they know this limitation and agree they=E2=80=99ll adhe=
re to
it.  It=E2=80=99s also a stupid way.)

> So instead of adding two options (for stream and for nbd), it seems bette=
r to
> add only one for generic layer.

I don=E2=80=99t know.  It doesn=E2=80=99t work generically, so I don=E2=80=
=99t know whether it
should be a generic option.

> Then, it becomes possible to run guest on image with compress=3Don. It's =
a side
> effect, but still it should work correctly.

How so?  compress=3Don only works if every party involved only writes to
any cluster of the image exactly once.  That is just not the case for
guests unless they know this limitation, and even I don=E2=80=99t see a use=
 case.

> I think the simplest thing is to just run normal write, if compressed wri=
te
> failed because of reallocation. We should check that on that failure-path
> ENOTSUP is returned and handle it for compress=3Don option by fallback to
> normal write in generic block/io.c

It seems wrong to not compress data with compress=3Don.

> (Note, that in case with stream we rewrite only unallocated clusters)

Yes, but if the stream job writes the cluster before the guest, the
guest gets an I/O error.


By the way, the other thing I wondered was whether this should be a
filter driver instead (if it makes sense at all).  Such a filter driver
would at least be sufficiently cumbersome to use that probably only
users who understand the implications would make use of it (1B above).


I=E2=80=99m not against adding a generic compress=3Don option if we ensure =
that it
actually works generically (2 above).  It doesn=E2=80=99t right now, so I d=
on=E2=80=99t
think this is right.

I=E2=80=99m already not sure whether it=E2=80=99s really possible to suppor=
t generic
compressed writes in qcow2.  I suppose it=E2=80=99d be at least awkward.  I=
n
theory it should work, it=E2=80=99s just that we can=E2=80=99t keep track o=
f subcluster
allocations, which in the worst case means that some compressed clusters
take up a whole cluster of space.

For VMDK...  I suppose we could consider a new flag for block drivers
that flags whether a driver supports arbitrary compressed writes or has
the old limitations.  compress=3Don could then refuse to work on any block
driver but the ones that support arbitrary compressed writes.


Our current model (1A) is simply to ensure that all compressed writes
can adhere to the limitations.  As I=E2=80=99ve said above, extending this =
to
NBD would mean adding some NBD negotiation so both client and server
agree on this limitation.  That seems kind of reasonable from the qemu
side, but probably very unreasonable from an NBD side.  Why would NBD
bother to reproduce qemu=E2=80=99s limitations?


So these are the three ways (1A, 1B, 2) I can imagine.  But just adding
a generic option that unsuspecting users are not unlikely to use but
that simply doesn=E2=80=99t work generically doesn=E2=80=99t seem right to =
me.

Max


--0ntlWQojfiabiKVugCSuF331LVIvB3f4H--

--gWzTNzs3fTcBwvKluYrzQ3vCI04jfEH27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2u6HsACgkQ9AfbAGHV
z0Cjlgf8DoqguJa3ACImgMNAeCuO2pCPVTkgCmDUybeF8S72GsWt3S86p+eXmyqB
MKQBwxx4+VglB8JV2l4C44+5OtjyKS+QdVZ+nKUasXwbPw8HlmrW3siypTR3MS0f
Kg6LpmR8AyA+k9KwQOywgqIY82rAqYPi3tW3YDV4A7WLPdp+KO16RdTju71SKwa7
CBlF/z5HJSHNsub7royX2UQKE6epSDOCR0P/B/YJfrBrlC4hp3MzD5Kkd9Hf5+bg
QVcnCHV4uX5I352++AKeGL17fRSlNrhp9uhvK+z3T4ckshIDbxYAt5kNAgYp2Cj8
mrKXsjjuKFeNLfS7E7VxXuqJU4Bt5w==
=x86d
-----END PGP SIGNATURE-----

--gWzTNzs3fTcBwvKluYrzQ3vCI04jfEH27--


