Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA220C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626C2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIxKRSiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0O3h-0000Sh-TE
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0O2s-0008NP-JC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:45:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0O2m-0003M6-5Z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595936715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HeeEqTWS1cMW4FTz5TxWtoodw4Jb6YvVmQA0zpqv1wQ=;
 b=PIxKRSiZFLTeI6nZsBA0Sy7bn6XemL7y96DfjGiGMUoNgOexf3b3Rc+0SqLrVC1SQ1ZPDE
 OwS/bh3alFDi6cSmaxMWjHCX/xAzw1Fobv3SGumiAo4BhSV7/nXzw7R7tbYkMG4UHpgNcj
 +9ffP2qH0j5IgJtMqYefF2fMQ7trznQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-KpujPiBCONGD_Mlf6gxE8w-1; Tue, 28 Jul 2020 07:45:11 -0400
X-MC-Unique: KpujPiBCONGD_Mlf6gxE8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 016828017FB;
 Tue, 28 Jul 2020 11:45:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-145.ams2.redhat.com
 [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 325ED726B6;
 Tue, 28 Jul 2020 11:45:02 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Bruce Rogers <brogers@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
 <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
 <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
 <ee1fa866-6d7d-bb7c-e811-4d94d9aa3459@virtuozzo.com>
 <dc30924a-11f8-f452-837e-ae5ee7ec9cc1@redhat.com>
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
Message-ID: <0e175bbb-6d5e-f509-7a4f-e3e4769c13a1@redhat.com>
Date: Tue, 28 Jul 2020 13:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dc30924a-11f8-f452-837e-ae5ee7ec9cc1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fJmBSE1mD7sHU4ZueqTl5fgl8GNpCJfog"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fJmBSE1mD7sHU4ZueqTl5fgl8GNpCJfog
Content-Type: multipart/mixed; boundary="Fap77OmQdllUuxB9YJpseqEiBe5MuvYY6"

--Fap77OmQdllUuxB9YJpseqEiBe5MuvYY6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.07.20 13:35, Paolo Bonzini wrote:
> On 28/07/20 13:33, Vladimir Sementsov-Ogievskiy wrote:
>>> Thanks for both your investigation.=C2=A0 Does the attached patch help?
>>
>> For me, the reproducer is fixed with your patch.
>=20
> Is it possible to make a quick testcase using qemu-io?

This seems to work:

$ qemu-img create -f qcow2 -o cluster_size=3D512 base.qcow2 512
$ qemu-img create -f qcow2 -o cluster_size=3D512 -F qcow2 -b base.qcow2 \
  top.qcow2 1024
$ qemu-io -c 'write -P 42 0 512' top.qcow2
$ qemu-io -c 'read -v 0 1024' top.qcow2

That should print 512 times =E2=80=9C2a=E2=80=9D and then 512 times =E2=80=
=9C00=E2=80=9D, but beyond
512, the buffer stays uninitialized; instead, the first 512 bytes are
zeroed.  (With the patch, it works as expected.)


--Fap77OmQdllUuxB9YJpseqEiBe5MuvYY6--

--fJmBSE1mD7sHU4ZueqTl5fgl8GNpCJfog
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8gD70ACgkQ9AfbAGHV
z0BsBwgAvriHLQP+N/Jr6UIBzrTVwV5+GOcvwsnuh+1C++PvtR59+fZQHbqv3EAt
LWnnMQcQj/P13hCARAN2jOrNxcKvehuLamf72jsWBdQRBuIVx8GLXhDWYy5kib0k
B5vTGpomijX9w257lGpbhO+6ZMoj9USCWtraWIYXnB23wuMqeneZN/S3HhjP7Xct
CQT67zzEvV3ZPNTM8eHyxACXM9o7v04Xlq5f+xvr7kEBCEVTyD3eC3hsE0o3NGf1
exwD0MAc8Av+kayn7UuibUANM3cMewgnxyPpbyQHuxAnha4VgS2vD2B4JmBmXLP4
SpDekmgGuCan5jeFD10hvXXW6cTYfQ==
=hhYx
-----END PGP SIGNATURE-----

--fJmBSE1mD7sHU4ZueqTl5fgl8GNpCJfog--


