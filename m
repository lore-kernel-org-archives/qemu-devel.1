Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6712520722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3rIYuVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6712520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaCI-0004t2-NT
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqaBj-0004SC-Cb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:41:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqaBh-0000XK-8k
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593600116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0DLLCuDB2R0MKsDMRdOWOSZfgxNsiC6qBFRjtYQE/s=;
 b=E3rIYuVJ8KwHnl/5ZJtx0wvesp1wpUA9vN7hq+VMzRnJ80vjtw4UYFfRAZA/JOi9O+zMs7
 UvMMjY3lj5BkvG1w99klL775+eh1tDDRj04oERc137qEkD1yRgrg73ODDWWQa7oIGqRaPW
 LZIuzjcCn7AYuIJP2LeoqB4qRyZUMb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-imFL9vXBMUW502RMba1JXA-1; Wed, 01 Jul 2020 06:41:54 -0400
X-MC-Unique: imFL9vXBMUW502RMba1JXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D401107B0E1;
 Wed,  1 Jul 2020 10:41:52 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9540019C58;
 Wed,  1 Jul 2020 10:41:46 +0000 (UTC)
Date: Wed, 1 Jul 2020 11:41:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 14/21] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
Message-ID: <20200701104145.GG126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <d979961dd356ed375b9bca34d99ed2e669072407.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d979961dd356ed375b9bca34d99ed2e669072407.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:36AM -0700, elena.ufimtseva@oracle.com wrote:
> @@ -54,6 +57,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondit=
ion cond,
>      case PCI_CONFIG_READ:
>          process_config_read(ioc, pci_dev, &msg);
>          break;
> +    case BAR_WRITE:
> +        process_bar_write(ioc, &msg, &local_err);
> +        break;
> +    case BAR_READ:
> +        process_bar_read(ioc, &msg, &local_err);
> +        break;

These functions are more than BAR read/write functions, they are general
address space read/write functions. This is could be a security problem
in the future because the client has access to more than just the PCI
device they are supposed to communicate with.

I don't have a strong opinion against leaving it as-is, but wanted to
mention it because the current approach is risky as a long-term
solution. The protocol message could have a uint8_t bar_index field or
the remote device could validate that addr falls within the device BARs.

>      default:
>          error_setg(&local_err, "Unknown command (%d) received from proxy=
 \
>                     in remote process pid=3D%d", msg.cmd, getpid());
> @@ -143,3 +152,89 @@ static void process_config_read(QIOChannel *ioc, PCI=
Device *dev,
> =20
>      mpqemu_msg_send(&ret, ioc);
>  }
> +
> +static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **e=
rrp)
> +{
> +    BarAccessMsg *bar_access =3D &msg->data1.bar_access;
> +    AddressSpace *as =3D
> +        bar_access->memory ? &address_space_memory : &address_space_io;
> +    MPQemuMsg ret =3D { 0 };
> +    MemTxResult res;
> +
> +    if (!is_power_of_2(bar_access->size) ||
> +       (bar_access->size > sizeof(uint64_t))) {
> +        ret.data1.u64 =3D UINT64_MAX;
> +        goto fail;
> +    }
> +
> +    res =3D address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIE=
D,
> +                           (void *)&bar_access->val, bar_access->size,
> +                           true);

(void *)&bar_access->val doesn't work on big-endian hosts. A uint64_t ->
{uint32_t, uint16_t, uint8_t} conversion must be performed before the
address_space_rw() call analogous to what process_bar_read() does.

Although it's unlikely that this will be run on big-endian hosts anytime
soon, it's good practice to keep the code portable when possible.

> +    case BAR_WRITE:
> +    case BAR_READ:
> +        if (msg->size !=3D sizeof(msg->data1)) {
> +            return false;
> +        }

Is there a check that the number of passed fds is zero somewhere?

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78aGkACgkQnKSrs4Gr
c8gKPgf9EHXwOjSw6FCKtyffrdXn4Mn6XUMBRNv6R5o2+Dvx6psHGlig/IHT4ZT+
aBAO5aX3+aXdL1UuG2wOtaLgSJJxyW5FEuyaZ3zkQ1tWZiE66Q5jdIxv1tdtZRNP
X3MkqR7lCQVS6vExMFLgk+zhcl4P6ik1EpCWFHGf6v4WHROVCN6oGnvfwkv/4d61
Cf4g1oV7QF8rkwWGM34COesskCMHW5iqvyIOWBlr5/MHMIZBJtKNbbzAjRiH0W9W
qMHk+HZ7bHWitGQK5aAaupEUX+1W/uLnoFZwQ9nHqan3CDkYQc5EmhK/u+gpi+Zm
do2HDxRl74AcpYHCXffjmp0jAd5VXQ==
=WHyM
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--


