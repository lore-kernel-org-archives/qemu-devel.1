Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E70C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6058F2075E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYyi8wxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbPg-00016S-DT
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVbOd-0000Ru-8e
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:44:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVbOc-0007ox-91
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588599873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9NQnpcYkvkVbRU7brf5mdo6rVsXNH5B1d5Jbd/CtPk=;
 b=JYyi8wxY2QcFqgYo0iLNINAvDEjPbWDoS/+3PdIDeaoHeq2tkYuwaq39zh8CmgDErTFjga
 Jfzqb/N3Adqs+AZGMALhAOysOlVxXW4g620v0+nBkEW1OHizY04hZeukKnTy30jGVuGsUe
 hyASqcsb3IgIg3Zecgl7iH0IJq7b7D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-rOnuNOlhNESDXp9MbDgAJw-1; Mon, 04 May 2020 09:44:29 -0400
X-MC-Unique: rOnuNOlhNESDXp9MbDgAJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA50D835B41;
 Mon,  4 May 2020 13:44:28 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66EC562482;
 Mon,  4 May 2020 13:44:28 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] qcow2: Expose bitmaps' size during measure
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-5-eblake@redhat.com>
 <969af6d7-a4e4-b01b-b93b-d0f983782cfc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c135074b-70f4-475f-439a-8fc97568e14a@redhat.com>
Date: Mon, 4 May 2020 08:44:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <969af6d7-a4e4-b01b-b93b-d0f983782cfc@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 6:36 AM, Max Reitz wrote:
> On 21.04.20 23:20, Eric Blake wrote:
>> It's useful to know how much space can be occupied by qcow2 persistent
>> bitmaps, even though such metadata is unrelated to the guest-visible
>> data.  Report this value as an additional field.  Update iotest 190 to
>> cover it and a portion of the just-added qemu-img bitmap command.
>>
>> The addition of a new field demonstrates why we should always
>> zero-initialize qapi C structs; while the qcow2 driver still fully
>> populates all fields, the raw and crypto drivers had to be tweaked.
>>
>> See also: https://bugzilla.redhat.com/1779904
>>
>> Reported-by: Nir Soffer <nsoffer@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>>   # @fully-allocated: Image file size, in bytes, once data has been writ=
ten
>> -#                   to all sectors.
>> +#                   to all sectors, when copying just guest-visible con=
tents.
>> +#
>> +# @bitmaps: Additional size required for bitmap metadata not directly u=
sed
>> +#           for guest contents,
>=20
> Not sure how I feel about the =E2=80=9Cnot directly used for guest conten=
ts=E2=80=9D,
> because it feels a bit superfluous, and it sounds like there might be
> bitmap data that is directly used for guest contents.

Hmm. I was trying to make it obvious that bitmap size is separate from=20
fully-allocated (and not double-counted), but you may have a point that=20
just using "Additional size required for bitmap metadata, when that=20
metadata can be copied in addition..." would work.

>=20
>>                                   when that metadata can be copied in ad=
dition
>> +#           to guest contents. (since 5.1)
>>   #
>>   # Since: 2.10
>>   ##
>>   { 'struct': 'BlockMeasureInfo',
>> -  'data': {'required': 'int', 'fully-allocated': 'int'} }
>> +  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'in=
t'} }
>=20
> Why is @bitmaps optional?  I.e., what does absence mean, besides =E2=80=
=9Cnot
> supported yet=E2=80=9D?
>=20
> Right now, absence means anything in =E2=80=9Cformat doesn=E2=80=99t supp=
ort bitmaps, so
> nothing can be copied=E2=80=9D, =E2=80=9Cno input image given, so there=
=E2=80=99s no data on
> bitmaps=E2=80=9D, to =E2=80=9C0 bytes to copy=E2=80=9D.
>=20
> I think in the latter case we should emit it as 0, maybe even in the
> former case, because I think the fact that there won=E2=80=99t be any bit=
map
> data to copy might be interesting.  (And it=E2=80=99s also definitely 0, =
not
> just =E2=80=9Cdon=E2=80=99t know=E2=80=9D.)
>=20
> I suppose absence does make sense in case the user didn=E2=80=99t specify=
 an
> input image, because then we just really don=E2=80=99t know.

The patch will require a tweak to report an explicit 0 (when there is=20
nothing to be copied), but doing that makes sense (explicit 0 for v3=20
qcow2 images, and maybe even for v2, but omitted for other formats that=20
have no bitmap support).


>> @@ -4739,6 +4742,28 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *=
opts, BlockDriverState *in_bs,
>>               goto err;
>>           }
>>
>> +        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
>> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
>> +                const char *name =3D bdrv_dirty_bitmap_name(bm);
>> +                uint32_t granularity =3D bdrv_dirty_bitmap_granularity(=
bm);
>> +                uint64_t bmbits =3D DIV_ROUND_UP(bdrv_dirty_bitmap_size=
(bm),
>> +                                               granularity);
>> +                uint64_t bmclusters =3D DIV_ROUND_UP(DIV_ROUND_UP(bmbit=
s,
>> +                                                                CHAR_BI=
T),
>=20
> I suppose if we allowed CHAR_BIT to be anything but 8, it would be wrong
> to use it here.  So maybe just a plain 8 would be more correct; although
> I suppose CHAR_BIT kind of describes what constant we want here.

POSIX requires CHAR_BIT to be 8.  (C99 allows some odd machines where=20
CHAR_BIT is 9, 16, or even 32, but we don't ever try to port to such=20
machines).

>> +=3D=3D Huge file with bitmaps =3D=3D
>> +
>> +required size: 2199023255552
>> +fully allocated size: 2199023255552
>> +required size: 335806464
>> +fully allocated size: 2199359062016
>> +bitmaps size: 537198592
>> +required size: 18874368
>> +fully allocated size: 2199042129920
>> +bitmaps size: 545259520
>=20
> Looks correct.
>=20
> (It might be nicer to calculate the reference value in the script,
> because this way I had to verify it by hand, but, well, now I did verify
> it, so...)

Feels like duplicate work, which would require tweaking in two spots if=20
we ever change our implementation or the qcow2 format is further=20
enhanced, but it would also make it obvious that we are aware of the=20
impact of such future changes. Okay, I'll see what I can add.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


