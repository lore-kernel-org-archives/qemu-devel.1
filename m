Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50967C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EED921655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNYLwFOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EED921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHRX-0005Ti-3k
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiH6M-0002YP-G7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiH6I-000466-Dn
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:09:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiH6H-00040e-SE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576843784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZRqxg4jzyd9qbid/kjBvm+qghL7VCGpqXcohMXHAaCY=;
 b=ZNYLwFOpnWMpRGo/RW/F4tX70rW0FbrOIOr60hbA4RAZnlVMQMtPrVgqNbO5e2OMA4ytof
 rc9qOzYMNwdyaqn7ggy5JmuYo8b1CdelY+1xrFZbt2DBHeVGxBG6pQwlPJUGO1xNG4FONH
 QfG+Y0NpTF0TR3xYLy57u7ydAi6nt10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-lAiL9e2HNwa3roqVZ68f5w-1; Fri, 20 Dec 2019 07:09:42 -0500
X-MC-Unique: lAiL9e2HNwa3roqVZ68f5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9AD5184BEC6;
 Fri, 20 Dec 2019 12:09:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E32126FB9;
 Fri, 20 Dec 2019 12:09:40 +0000 (UTC)
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
To: Kevin Wolf <kwolf@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
 <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
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
Message-ID: <3840096c-55a9-58df-4320-8394492fb387@redhat.com>
Date: Fri, 20 Dec 2019 13:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G0uH2Sg7f6QUp1BGvsmGZAhZmwSp5oCiH"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G0uH2Sg7f6QUp1BGvsmGZAhZmwSp5oCiH
Content-Type: multipart/mixed; boundary="Mo1mgEk2ea8Ys7uBZwucum51DivYgBs1p"

--Mo1mgEk2ea8Ys7uBZwucum51DivYgBs1p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.12.19 12:24, Kevin Wolf wrote:
> Am 20.12.2019 um 11:48 hat Max Reitz geschrieben:
>> On 20.12.19 11:26, Kevin Wolf wrote:
>>> Am 19.12.2019 um 15:38 hat Max Reitz geschrieben:
>>>> fuse-export-add allows mounting block graph nodes via FUSE on some
>>>> existing regular file.  That file should then appears like a raw disk
>>>> image, and accesses to it result in accesses to the exported BDS.
>>>>
>>>> Right now, we only set up the mount point and tear all mount points do=
wn
>>>> in bdrv_close_all().  We do not implement any access functions, so
>>>> accessing the mount point only results in errors.  This will be
>>>> addressed by a followup patch.
>>>>
>>>> The set of exported nodes is kept in a hash table so we can later add =
a
>>>> fuse-export-remove that allows unmounting.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>
>>>> diff --git a/qapi/block.json b/qapi/block.json
>>>> index 145c268bb6..03f8d1b537 100644
>>>> --- a/qapi/block.json
>>>> +++ b/qapi/block.json
>>>> @@ -317,6 +317,29 @@
>>>>  ##
>>>>  { 'command': 'nbd-server-stop' }
>>>> =20
>>>> +##
>>>> +# @fuse-export-add:
>>>> +#
>>>> +# Exports a block graph node on some (file) mountpoint as a raw image=
.
>>>> +#
>>>> +# @node-name: Node to be exported
>>>> +#
>>>> +# @mountpoint: Path on which to export the block device via FUSE.
>>>> +#              This must point to an existing regular file.
>>>> +#
>>>> +# @writable: Whether clients should be able to write to the block
>>>> +#            device via the FUSE export. (default: false)
>>>> +#
>>>> +# Since: 5.0
>>>> +##
>>>> +{ 'command': 'fuse-export-add',
>>>> +  'data': {
>>>> +      'node-name': 'str',
>>>> +      'mountpoint': 'str',
>>>> +      '*writable': 'bool'
>>>> +  },
>>>> +  'if': 'defined(CONFIG_FUSE)' }
>>>
>>> Can this use a BlockExport union from the start like I'm introducing in
>>> the storage daemon series, together with a generic block-export-add?
>>
>> Hm, you mean still adding a FuseExport structure that would be part of
>> BlockExport and then dropping fuse-export-add in favor of a
>> block-export-add that we want anyway?
>=20
> Yes.
>=20
>>> It also looks like node-name and writable should be part of the common
>>> base of BlockExport.
>>
>> node-name definitely, I=E2=80=99m not so sure about writable.  Or, to be=
 more
>> precise, I think that if we want writable to be in the base, we also
>> want growable to be there: Both are primarily options for the
>> BlockBackend that the exports use.
>>
>> But both of course also need to be supported by the export
>> implementation.  nbd can make its BB growable all it wants, but that
>> doesn=E2=80=99t make it work.
>=20
> Right. Pragmatically, I think exports are very like to support writable,
> but probably rather unlikely to support growable. So I do think there
> would be a point for making writable part of the common base, but not
> growable.

True.

But there=E2=80=99s nothing that inherently binds it to FUSE, so I think bo=
th
from an implementation=E2=80=99s POV and from a user=E2=80=99s POV, it look=
s just as
generic as =E2=80=9Cwritable=E2=80=9D.  But that=E2=80=99s theory.  I agree=
 that in practice, it
won=E2=80=99t be as generic.

(I realize this doesn=E2=80=99t help much in finding out what we should do.=
)

>> So if we kept writable and growable in the common base, then the schema
>> would give no information about what exports actually support them.
>>
>> On one hand, I don=E2=80=99t know whether it=E2=80=99s important to have=
 this
>> information in a static form, or whether it=E2=80=99s sufficient to lear=
n at
>> runtime.
>>
>> On the other, I don=E2=80=99t know whether it=E2=80=99s important to hav=
e those fields
>> in the base or not.  Would it make a difference on the wire?
>=20
> Not for the command itself, so I think we're free to change it later. It
> might make a difference for introspection, though, not sure. Markus?

Yes, I asked because I=E2=80=99m wondering whether it would be more cumbers=
ome
to users if we didn=E2=80=99t keep it in the base structure.

The duplication depends on how we want to design the command.  Should
the export implementations receive a ready-to-use BB?  Or just a
node-name?  In the latter case, we wouldn=E2=80=99t get rid of duplicated c=
ode
by having writable/growable in the base.  For the former, it could, but
then again, just taking the WRITE permission and making the BB growable
isn=E2=80=99t that bad to duplicate.

Something to consider is that of course the current NBD code wants a
node-name and not a BB.  So if we decided to generally give export
implementations a BB, then the initial implementation of
qmp_block_export_add() would look a bit freaky: It would first branch
off to qmp_nbd_server_add(), and then open the BB for the =E2=80=9Ccommon=
=E2=80=9D case,
but this common case only exists for FUSE (right now).

OTOH, right now we=E2=80=99re free to decide whether we open the BB in
qmp_block_export_add() or fuse.c, and so we might as well just do it in
the former.  If we later find out that this was a stupid idea, we can
always move it into fuse.c.


Now I don=E2=80=99t quite know where I=E2=80=99m trying to get with this.

I suppose it means that we should start with qmp_block_export_add()
creating the BB and handing it over to the export implementation.

Then it makes sense to me that the BB should be ready to go, i.e. have
all the necessary flags and permissions set.  If so, writable and
growable should be part of the base, so the WRITE permission can be
taken and allow_write_beyond_eof can be set.

But there=E2=80=99s a catch: The common code actually cannot pass on a
ready-to-go BB, because it depends on the export type what kinds of
permissions can be shared.  FUSE exports are fine with sharing the
RESIZE permission, but NBD can=E2=80=99t do that.  And, well, if we require=
 the
export implementation to adjust the permissions anyway, we might as well
require it to take WRITE if necessary.  And then the argument for
avoiding duplication is gone.

> Having it in the base might allow us to remove some duplication in the
> code. Probably not much, though, so not too important.
>=20
>>> Unfortunately this would mean that I can't use the
>>> same BlockExportNbd for the existing nbd-server-add command any more. I
>>> guess I could somehow get a shared base type for both, though.
>>
>> Hm.  This sounds like you want to make it your problem.  Can I take that
>> to mean that you want to implement block-export-add and I can wait with
>> v2 until that=E2=80=99s done? :-)
>=20
> The NBD integration, yes. I already added the BlockExport type to my
> patches, too, but I expect you would beat me to it. I'm not currently
> planning to write a block-export-add because it doesn't add anything new
> for the storage daemon, so FuseExport and the command this is your part.
> The type currently only exists for --export.

That=E2=80=99s too bad. ;-)

I was mostly asking because I imagine it would actually make more sense
to add block-export-add in a seperate (prerequisite) series.

Max


--Mo1mgEk2ea8Ys7uBZwucum51DivYgBs1p--

--G0uH2Sg7f6QUp1BGvsmGZAhZmwSp5oCiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl38ugIACgkQ9AfbAGHV
z0A/lQf8COk6SVH1YnxVNVmmUfKkG3z2XPVNk0KIFlzfijFvyACtVqUEL4s/uIGh
EM/4e7H1JmmxthXNBMjtRP78ntx8iTnEeRdcx5mA19lfmrl7rRwKwAcw/aQ12tPs
o7oDgUr+R8PH/rChHbTg2g9YXU1YYL5gOZqgl6dhWZp76vgxIMVlUvvkrVJNx+pe
X6HIWgxEl+pTc7p+VdqbgvBpEjL/BNto4JzsIddYyONWVt8+uENEUX2S8q8uf31+
NAS6iCn+pVOiYRxjna1PxbPbpAChO+BBNrhgBOaKYBcE7E8vPRdEYRR1dNXfVxw4
v53ka3GZY6h/Qk4pXaRL1J6CTZmTog==
=JT3m
-----END PGP SIGNATURE-----

--G0uH2Sg7f6QUp1BGvsmGZAhZmwSp5oCiH--


