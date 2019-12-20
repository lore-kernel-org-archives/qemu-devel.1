Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2FEC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2752465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhlJcbJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2752465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFrO-0001ab-T4
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiFpv-0000MG-Uh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiFps-0005cA-9I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:48:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiFpr-0005Vz-QC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576838922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WMy0Pp71e6O9iKNwmkXWDFm8TwfOUahlM8uOg1Q6w4k=;
 b=DhlJcbJjRINUjISA57Psqu07vAyQwWU0gWiw3Z+Ekt8SHNZSg/KIcI19Kviu9tLbW65qzr
 19P76+iaWcFPyNLRRLRMdyoUP7t2y9nreQqgbJz3tycO72SreZ8uEzJsUV6eU7j0I1pCFs
 lWfm7avGXe+312Dg7gQbLIAL5wC2vpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-9sJHsSGROCaqG41St0sD1g-1; Fri, 20 Dec 2019 05:48:41 -0500
X-MC-Unique: 9sJHsSGROCaqG41St0sD1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B54800D50;
 Fri, 20 Dec 2019 10:48:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B709C26FBF;
 Fri, 20 Dec 2019 10:48:38 +0000 (UTC)
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
To: Kevin Wolf <kwolf@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
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
Message-ID: <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
Date: Fri, 20 Dec 2019 11:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WT0BcDmM7cwV36Kug89wtfF1NPriQrljz"
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
--WT0BcDmM7cwV36Kug89wtfF1NPriQrljz
Content-Type: multipart/mixed; boundary="7B8H0dt7gViE52DapiNnFDxshSu08V46V"

--7B8H0dt7gViE52DapiNnFDxshSu08V46V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.12.19 11:26, Kevin Wolf wrote:
> Am 19.12.2019 um 15:38 hat Max Reitz geschrieben:
>> fuse-export-add allows mounting block graph nodes via FUSE on some
>> existing regular file.  That file should then appears like a raw disk
>> image, and accesses to it result in accesses to the exported BDS.
>>
>> Right now, we only set up the mount point and tear all mount points down
>> in bdrv_close_all().  We do not implement any access functions, so
>> accessing the mount point only results in errors.  This will be
>> addressed by a followup patch.
>>
>> The set of exported nodes is kept in a hash table so we can later add a
>> fuse-export-remove that allows unmounting.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 145c268bb6..03f8d1b537 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -317,6 +317,29 @@
>>  ##
>>  { 'command': 'nbd-server-stop' }
>> =20
>> +##
>> +# @fuse-export-add:
>> +#
>> +# Exports a block graph node on some (file) mountpoint as a raw image.
>> +#
>> +# @node-name: Node to be exported
>> +#
>> +# @mountpoint: Path on which to export the block device via FUSE.
>> +#              This must point to an existing regular file.
>> +#
>> +# @writable: Whether clients should be able to write to the block
>> +#            device via the FUSE export. (default: false)
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'command': 'fuse-export-add',
>> +  'data': {
>> +      'node-name': 'str',
>> +      'mountpoint': 'str',
>> +      '*writable': 'bool'
>> +  },
>> +  'if': 'defined(CONFIG_FUSE)' }
>=20
> Can this use a BlockExport union from the start like I'm introducing in
> the storage daemon series, together with a generic block-export-add?

Hm, you mean still adding a FuseExport structure that would be part of
BlockExport and then dropping fuse-export-add in favor of a
block-export-add that we want anyway?

> It also looks like node-name and writable should be part of the common
> base of BlockExport.

node-name definitely, I=E2=80=99m not so sure about writable.  Or, to be mo=
re
precise, I think that if we want writable to be in the base, we also
want growable to be there: Both are primarily options for the
BlockBackend that the exports use.

But both of course also need to be supported by the export
implementation.  nbd can make its BB growable all it wants, but that
doesn=E2=80=99t make it work.

So if we kept writable and growable in the common base, then the schema
would give no information about what exports actually support them.

On one hand, I don=E2=80=99t know whether it=E2=80=99s important to have th=
is
information in a static form, or whether it=E2=80=99s sufficient to learn a=
t
runtime.

On the other, I don=E2=80=99t know whether it=E2=80=99s important to have t=
hose fields
in the base or not.  Would it make a difference on the wire?

> Unfortunately this would mean that I can't use the
> same BlockExportNbd for the existing nbd-server-add command any more. I
> guess I could somehow get a shared base type for both, though.

Hm.  This sounds like you want to make it your problem.  Can I take that
to mean that you want to implement block-export-add and I can wait with
v2 until that=E2=80=99s done? :-)

Max

> Markus, any thoughts on these QAPI interfaces?
>=20
> Kevin


--7B8H0dt7gViE52DapiNnFDxshSu08V46V--

--WT0BcDmM7cwV36Kug89wtfF1NPriQrljz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl38pwUACgkQ9AfbAGHV
z0AU1Af+Jkz/mE+cZM0FkD56EEpo0HEn0kv6IvaxrKn8B+uGVnpQxU4yBufkdnh3
VUO3O7EY44AOhx7gm4EzV6UXjkNlv7Z1qsqAUqppkDM7xp+H/qiqM6MrOtmwY+4R
c3T/k/C4Qd5ghmWcrxsux6kOlCshz1Bcuw42pEPz7SrkjKEJ6L6F5qRxu2YWWrPY
hPUBhhfotNEAbF6GyrYP/cIbP/Dbqd18RKBKpNhTls1LPFryjuAdaeUXk5xKomlQ
AsE4JW46JC9SSNWTueSWk8guEPSeENIA0qQBZQzBt8VxEiEN2Vk61JT8gojG3tQm
+ztWM9tYzFLqn9VJFA0W4wro3+RpbA==
=ZrJY
-----END PGP SIGNATURE-----

--WT0BcDmM7cwV36Kug89wtfF1NPriQrljz--


