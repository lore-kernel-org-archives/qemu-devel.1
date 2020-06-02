Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF1EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88E1206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwwgSYl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88E1206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg4d4-0007o3-3G
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 06:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jg4cP-0007Ja-KM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:58:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35926
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jg4cN-0005jJ-6o
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591095481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1n4qjpsYLAGs3JKlPl86bSBchJoy8SlLbkJ9eYiUbDg=;
 b=BwwgSYl8NUiZmiCT0XWqwOecWEwXZHyhpmCydGk8ZQpCxRaqasYemyVr5mh7rETywNU0ox
 gDpeTy2mbjV+aheUND1HV/Gh6Kvc8SJttQtnaHOVF0smkWIJ7VJM6FsPFh5thNYlAc3nwY
 fUM+911qx4Ed1ofZN6kAa7bAZ2eeS3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ggwicqkUMNaIlIrE_xZytg-1; Tue, 02 Jun 2020 06:56:37 -0400
X-MC-Unique: ggwicqkUMNaIlIrE_xZytg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D8AD107BEF5;
 Tue,  2 Jun 2020 10:56:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-81.ams2.redhat.com
 [10.36.114.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F48F2DE7C;
 Tue,  2 Jun 2020 10:56:34 +0000 (UTC)
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Peter Krempa <pkrempa@redhat.com>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200518162648.GC2995787@angien.pipo.sk>
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
Message-ID: <1216f9b8-d9b6-204c-b0a9-06c14b286413@redhat.com>
Date: Tue, 2 Jun 2020 12:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518162648.GC2995787@angien.pipo.sk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ItF5TQdGSX5W6FFJKx0ekxXoFpsfFEos9"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ItF5TQdGSX5W6FFJKx0ekxXoFpsfFEos9
Content-Type: multipart/mixed; boundary="eRE6or41M7h5ciDVpai661dmwi0QJtbYE"

--eRE6or41M7h5ciDVpai661dmwi0QJtbYE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.05.20 18:26, Peter Krempa wrote:
> On Wed, May 13, 2020 at 16:56:10 +0200, Max Reitz wrote:
>> This command allows mapping block node names to aliases for the purpose
>> of block dirty bitmap migration.
>>
>> This way, management tools can use different node names on the source
>> and destination and pass the mapping of how bitmaps are to be
>> transferred to qemu (on the source, the destination, or even both with
>> arbitrary aliases in the migration stream).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
> [...]
>=20
>> ---
>>  qapi/migration.json            | 36 ++++++++++++++++++++
>>  migration/block-dirty-bitmap.c | 60 ++++++++++++++++++++++++++++++++--
>>  2 files changed, 94 insertions(+), 2 deletions(-)
>=20
> I just started to write some quick and dirty hacks to test use of this
> infrastructure in libvirt. I have 2 quick observations for now:
>=20
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..97037ea635 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1621,3 +1621,39 @@
>>  ##
>>  { 'event': 'UNPLUG_PRIMARY',
>>    'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @MigrationBlockNodeMapping:
>> +#
>> +# Maps a block node name to an alias for migration.
>> +#
>> +# @node-name: A block node name.
>> +#
>> +# @alias: An alias name for migration (for example the node name on
>> +#         the opposite site).
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'MigrationBlockNodeMapping',
>> +  'data': {
>> +      'node-name': 'str',
>> +      'alias': 'str'
>> +  } }
>=20
> We'd probably like a
> 'nodename:bitmapname' -> 'alias' mapping so that we can select which
> bitmaps to migrate and where to migrate them to.

Sure, entirely doable.

I think Vladimir is right that we=E2=80=99d want separate node and bitmap
aliases then, though, because the migration stream has both fields.
(Also, if we only had a single alias, you=E2=80=99d always need to call
migrate-set-bitmap-(node-)mapping on both ends to unpack that alias.
With separate node and bitmap aliases, it suffices to call it on one
end, just like the version in thie patch.)

> The specific use case
> is following:
>=20
> Libvirt supports migration without shared storage (NFS/etc) where we
> copy the disk images prior to the memory migration using qemu's NBD
> server and the blockdev-mirror job. By default and the most simple way
> which doesn't require users fudging with the disk images and copying
> backing images themselves is that we flatten all the backing chain
> during the copy ("sync":"full"). In this mode we'll need to do some
> merging of the bitmaps prior to finalizing the copy.
>=20
> It's not a problem to do it ourselves, but in the end we'll need to copy
> only certain bitmaps which will be created temporarily on the source to
> the destination where they'll be persisted.
>=20
> For now (until I implement the use of the dirty-bitmap-populate blockjob
> which I'm also doing in parallel with this kind of) when creating a
> snapshot we create a new active bitmap in the overlay for every active
> bitmap in the snapshotted image.
>=20
> When flattening we'll then need to merge the appropriate ones. As said
> it's not a problem to prepare all the bitmaps before but we then don't
> need to migrate all of them.
>=20
> By the way, that brings me to another question:
>=20
> Is there any difference of handling of persistent and non-persistent
> bitmaps? Specifically I'm curious what's the correct approach to do the
> shared storage migration case when the source and destination image is
> the same one. Should we also instruct to migrate the active ones? or are
> they migrated by writing them to the image and reloading them?

I hope Vladimir has answered your question sufficiently extensively. :)

>> +##
>> +# @migrate-set-bitmap-node-mapping:
>=20
> qemu-5.0 deprecated a bunch of migrate-set- specific commands in favor
> of migrate-set-parameters. Is it worth/necessary to add a new command
> here?

I wasn=E2=80=99t aware of that.  It would probably indeed make sense from a
user=E2=80=99s perspective.

It would make the implementation rather different, though, because
instead of putting the mapping locally (and statically) into
migration/block-dirty-bitmap.c, it would require putting it into the
central MigrationState.  Which isn=E2=80=99t to say it=E2=80=99d be worse. =
 I suppose
it=E2=80=99d be better, actually, but I=E2=80=99ll have to try to say for s=
ure.

You also suggested =E2=80=9Csetting nothing will clear the mapping=E2=80=9D=
 in your
second mail.  That would be a weird default.  Right now, the default for
all migration parameters is to leave them as-is, so it would be different.

The first question would be: What do you mean by =E2=80=9Cclear the mapping=
=E2=80=9D?
Reset it to the original identity mapping?  Or actually clear it, so
that no bitmap is migrated?  I presume the former, because the latter
can easily be achieved by passing an empty array.

I understand that it seems to make sense to be able to return to the
original identity mapping, but is there actually a use for this?  After
you have started using a custom mapping, wouldn=E2=80=99t you always use cu=
stom
mappings?

If there is a use for it, I think the better way to do it would be to
use an alternate type where an explicit null resets the mapping to the
identity mapping.

Max


--eRE6or41M7h5ciDVpai661dmwi0QJtbYE--

--ItF5TQdGSX5W6FFJKx0ekxXoFpsfFEos9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7WMGAACgkQ9AfbAGHV
z0ALRQgAknT3a8vKZESJUQ8EJGHmQhOLJ9/1lT0bfh/s2jYUd26o52c8Gtt/UUR7
KwSIC88VFBGp88UfkZdDEx0isaTfekJ0AvMPOMNS4sTWJ36MP2Z2hoV9nsiro8on
ed+AURMNuwPKs7WbAqMgpH2xgWnr+FuQhCxCoXlECQfHtE/Q0oAJN9+4OvvL9FF6
7JottYwEM+wlnLgEXjmVSS/eX2IQvJvZevhA1WN8JAkQfFYZwAQqKaKdTA0ksCQE
lVMjM7WDpc0Lo6Zjf6XM+yILRaSP1diCJYj2b4HRmEvAwk2mfRIylpSRFTXZPf5d
c1ZdWgnKF1HdHe1qhrTSzwL17YmINg==
=3/t6
-----END PGP SIGNATURE-----

--ItF5TQdGSX5W6FFJKx0ekxXoFpsfFEos9--


