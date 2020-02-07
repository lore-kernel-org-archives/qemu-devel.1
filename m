Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D3C35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FD1214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQYTAtws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FD1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j054e-0001kp-Kl
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j04nQ-0003UJ-ID
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j04nO-0004ur-6y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:39:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j04nM-0004u6-Nd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581086388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC6Zh7a0TJaRUhAecOoAB2peaVYGECdB1BmDARPH3kM=;
 b=EQYTAtwsC3nt+tGJX78jr8pnEya1bTG3mlpHLSX2bB2Dy5QQNQQdUbr3ePrHpK+LsE7Qjj
 MvL2AuguP3xFPtq7RQi42fhSusGQc2AHy3QYz+YQx7UnoHxRxLWKe9XKCmz+Ag44A5FGFm
 1ssMnAGP6nwJzJuxFptFGdgKiraCHQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-FepFPUgsPBSSTN3hyY1y_A-1; Fri, 07 Feb 2020 09:39:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D12DB10FB4B9;
 Fri,  7 Feb 2020 14:39:45 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 697542632C;
 Fri,  7 Feb 2020 14:39:45 +0000 (UTC)
Subject: Re: [PATCH v2] block: always fill entire LUKS header space with zeros
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207135520.2669430-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <df1a34df-e1b7-283f-a37b-79e7e3bfbe1d@redhat.com>
Date: Fri, 7 Feb 2020 08:39:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207135520.2669430-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FepFPUgsPBSSTN3hyY1y_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 7:55 AM, Daniel P. Berrang=C3=A9 wrote:
> When initializing the LUKS header the size with default encryption
> parameters will currently be 2068480 bytes. This is rounded up to
> a multiple of the cluster size, 2081792, with 64k sectors. If the
> end of the header is not the same as the end of the cluster we fill
> the extra space with zeros. This was forgetting that not even the
> space allocated for the header will be fully initialized, as we
> only write key material for the first key slot. The space left
> for the other 7 slots is never written to.
>=20

> The problem only exists when the disk image is entirely empty. Writing
> data to the disk image payload will solve the problem by causing the
> end of the file to be extended further.
>=20
> The change fixes it by ensuring that the entire allocated LUKS header
> region is fully initialized with zeros. The qemu-img check will still
> fail for any pre-existing disk images created prior to this change,
> unless at least 1 byte of the payload is written to.
>=20
> Fully writing zeros to the entire LUKS header is a good idea regardless
> as it ensures that space has been allocated on the host filesystem (or
> whatever block storage backend is used).

What's more, we avoid a possible bug where creating a LUKS image backed=20
by a block device protocol where the block device happens to already=20
contain stale data from an earlier use of that block device in a=20
different LUKS image, which could make it appear as though we have=20
populated key slots.  It's unlikely that those other slots would decode=20
the current image correctly (as the stale keyslot would decode to a=20
different master key), but being able to supply the passphrase to that=20
stale keyslot to decode garbage out of the new image does not seem=20
desirable.

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20

> +++ b/block/qcow2.c
> @@ -135,13 +135,16 @@ static ssize_t qcow2_crypto_hdr_init_func(QCryptoBl=
ock *block, size_t headerlen,
>       s->crypto_header.length =3D headerlen;
>       s->crypto_header.offset =3D ret;
>  =20
> -    /* Zero fill remaining space in cluster so it has predictable
> -     * content in case of future spec changes */
> +    /*
> +     * Zero fill all space in cluster so it has predictable
> +     * content, as we may not initialize some regions of the
> +     * header (eg only 1 out of 8 key slots will be initialized)
> +     */
>       clusterlen =3D size_to_clusters(s, headerlen) * s->cluster_size;
>       assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen, false)=
 =3D=3D 0);
>       ret =3D bdrv_pwrite_zeroes(bs->file,
> -                             ret + headerlen,
> -                             clusterlen - headerlen, 0);
> +                             ret,
> +                             clusterlen, 0);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Could not zero fill encryption he=
ader");
>           return -1;
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


