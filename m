Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E6C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8302076D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/LJrKgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8302076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRID-0006xH-8J
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLRGL-0004nC-K6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLRGA-0003bM-P3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600953965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cllcV/O5Cs6HQpclA/T4r0fvexRq6qM8c7KMY2S9jf4=;
 b=S/LJrKgOIboqStn43uu4QZpYAN8ASyVeznUGkD6EuzPu38iFwdRl/h2COF9RBsGZeu6/SW
 BaFCqKaKdiQXLHw8F2Xdyd5rxMR23ZeI0Px58+Z4ZQjeL+0Z3VOEj9ec+iR5JTUVMHVFfd
 hX6WMAqoSw5/ckdcWmFDd/+7zyh2Uug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-P-BQexegPPObKnXGWwSaUQ-1; Thu, 24 Sep 2020 09:26:02 -0400
X-MC-Unique: P-BQexegPPObKnXGWwSaUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 367EE1060B77;
 Thu, 24 Sep 2020 13:26:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-153.ams2.redhat.com
 [10.36.114.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2814773698;
 Thu, 24 Sep 2020 13:25:57 +0000 (UTC)
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
 <25a087d0-0306-574d-432b-0b5635ee7873@virtuozzo.com>
 <1508198c-d52b-08b3-602f-97ff3e83eaef@virtuozzo.com>
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
Message-ID: <9fd6c10b-0d37-30fe-5aad-bc50a0bbdc55@redhat.com>
Date: Thu, 24 Sep 2020 15:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1508198c-d52b-08b3-602f-97ff3e83eaef@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8d4Pth35wRiut2TntCPd8w4MLpTjIHVPy"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8d4Pth35wRiut2TntCPd8w4MLpTjIHVPy
Content-Type: multipart/mixed; boundary="ouWIMZG8etvOz2y6ID5LJT8sQi0UCqbVp"

--ouWIMZG8etvOz2y6ID5LJT8sQi0UCqbVp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.09.20 16:38, Vladimir Sementsov-Ogievskiy wrote:
> 17.09.2020 19:09, Andrey Shinkevich wrote:
>> On 04.09.2020 14:22, Max Reitz wrote:
>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>> Provide API for the COR-filter insertion/removal.
>> ...
>>>> Also, drop the filter child permissions for an inactive state when the
>>>> filter node is being removed.
>>> Do we need .active for that?=C2=A0 Shouldn=E2=80=99t it be sufficient t=
o just not
>>> require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
>>> node (i.e. perm =3D=3D 0 in cor_child_perm())?
>>>
>>> Of course, using an .active field works, too.=C2=A0 But Vladimir wanted=
 a
>>> similar field in the preallocate filter, and there already is in
>>> backup-top.=C2=A0 I feel like there shouldn=E2=80=99t be a need for thi=
s.
>>>
>>> .bdrv_child_perm() should generally be able to decide what permissions
>>> it needs based on the information it gets.=C2=A0 If every driver needs =
to
>>> keep track of whether it has any parents and feed that information into
>>> .bdrv_child_perm() as external state, then something feels wrong.
>>>
>>> If perm =3D=3D 0 is not sufficient to rule out any parents, we should j=
ust
>>> explicitly add a boolean that tells .bdrv_child_perm() whether there ar=
e
>>> any parents or not =E2=80=93 shouldn=E2=80=99t be too difficult.
>>
>>
>> The issue is that we fail in the bdrv_check_update_perm() with
>> ""Conflicts with use by..." if the *nperm =3D 0 and the *nshared =3D
>> BLK_PERM_ALL are not set before the call to the bdrv_replace_node().
>> The filter is still in the backing chain by that moment and has a
>> parent with child->perm !=3D 0.
>>
>> The implementation of=C2=A0 the .bdrv_child_perm()in the given patch is
>> similar to one in the block/mirror.c.
>>
>> How could we resolve the issue at the generic layer?
>>
>>
>=20
> The problem is that when we update permissions in bdrv_replace_node, we
> consider new placement for "to" node, but old placement for "from" node.
> So, during update, we may consider stricter permission requirements for
> "from" than needed and they conflict with new "to" permissions.
>=20
> We should consider all graph changes for permission update
> simultaneously, in same transaction. For this, we need refactor
> permission update system to work on queue of nodes instead of simple DFS
> recursion. And in the queue all the nodes to update should=C2=A0 be
> toplogically sorted. In this way, when we update node N, all its parents
> are already updated. And of course, we should make no-perm graph update
> before permission update, and rollback no-perm movement if permission
> update failed.

OK, you=E2=80=99ve convinced me, .active is good enough for now. O:)

> And we need topological sort anyway. Consider the following example:
>=20
> A -
> |=C2=A0 \
> |=C2=A0 v
> |=C2=A0 B
> |=C2=A0 |
> v=C2=A0 /
> C<-
>=20
> A is parent for B and C, B is parent for C.
>=20
> Obviously, to update permissions, we should go in order A B C, so, when
> we update C, all it's parents permission already updated. But with
> current approach (simple recursion) we can update in sequence A C B C (C
> is updated twice). On first update of C, we consider old B permissions,
> so doing wrong thing. If it succeed, all is OK, on second C update we
> will finish with correct graph. But if the wrong thing failed, we break
> the whole process for no reason (it's possible that updated B permission
> will be less strict, but we will never check it).

True.

> I'll work on a patch for it.

Sounds great, though I fear for the complexity.  I=E2=80=99ll just wait and=
 see
for now.

Max


--ouWIMZG8etvOz2y6ID5LJT8sQi0UCqbVp--

--8d4Pth35wRiut2TntCPd8w4MLpTjIHVPy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9snmQACgkQ9AfbAGHV
z0DkwAgAv1x4LsVzF8zmJbzMZen5vpWK6tySoUnnlRvT9ZQaXhLxyWg+8dp4UdkY
sXgeGOg/M0DDNyn2l5eoMUiLqAI5yKhNnLv/2RmgDernq0WAb1t3nUgKkOEarvFj
wVE5mmq0jP4haUSf7Lg+mFIRoSAdnCGLRxrUNogQWpxEpcpMofTlfCpVDiv013GS
FIPqT/wXiv5AwYCeSfE3sd2xuwMRTnoeJpLzdyZLDmn40xopg4VzvQQFkIxC9Psk
in6GmZxduV/Xkuhx+Use5bbPx/JWAZduhLNFhmvq2V4K5u6HKVpAjCjM4FP+RBzN
SN98h1GZm8n0OcZei43CP2M0q3ocQg==
=MMbI
-----END PGP SIGNATURE-----

--8d4Pth35wRiut2TntCPd8w4MLpTjIHVPy--


