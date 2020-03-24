Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6724206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlLaQb8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6724206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjvJ-0000PM-V8
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGjuM-00082B-VF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGjuL-0000YD-CF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:47:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGjuL-0000Y6-6v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585057672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xNyQNj/y/iyFExgj1ANDb/QUm5iyzaGaulCfjb7Oi/4=;
 b=JlLaQb8lPAvloFDN4Lh6dETiXywRtLQL7DYegi5P9GavJz/Mknea1YiGzo6OVUumkGTV9+
 3D/h4iHyR5wXlQsUESgyLYHxK7vFOluXV3EF8vs3arFEc1XSsOKmzSgRi1Mu9LMyk1/vAg
 WIzFtzR3LUh3oDT5xm+MrNG18n4nxCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-sEINl1PGMnm8-YMgA4M7_A-1; Tue, 24 Mar 2020 09:47:50 -0400
X-MC-Unique: sEINl1PGMnm8-YMgA4M7_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A1918CA241;
 Tue, 24 Mar 2020 13:47:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38DFE1001938;
 Tue, 24 Mar 2020 13:47:45 +0000 (UTC)
Subject: Re: backup transaction with io-thread core dumps
To: Dietmar Maurer <dietmar@proxmox.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
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
Message-ID: <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
Date: Tue, 24 Mar 2020 14:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1806708761.60.1585056799652@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MaRd21I1o3MpiOnFjCazTyMzAUUXqthGE"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MaRd21I1o3MpiOnFjCazTyMzAUUXqthGE
Content-Type: multipart/mixed; boundary="AK5DDXibRtgbCnogsPLrv6j8vo7Rp4QA2"

--AK5DDXibRtgbCnogsPLrv6j8vo7Rp4QA2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Dietmar,

I assume this is with master and has popped up only recently?

Maybe it has something to do with the recent mutex patches by Stefan, so
I=E2=80=99m Cc-ing him.

Max

On 24.03.20 14:33, Dietmar Maurer wrote:
> spoke too soon - the error is still there, sigh
> =20
>> This is fixed with this patch:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07249.html
>>
>> thanks!
>>
>>> On March 24, 2020 12:13 PM Dietmar Maurer <dietmar@proxmox.com> wrote:
>>>
>>> =20
>>> I get a core dump with backup transactions when using io-threads.
>>>
>>> To reproduce, create and start a VM with:
>>>
>>> # qemu-img create disk1.raw 100M
>>> # qemu-img create disk2.raw 100M
>>> #./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=3Dqmp,path=3D/=
var/run/qemu-test.qmp,server,nowait' -mon 'chardev=3Dqmp,mode=3Dcontrol' -p=
idfile /var/run/qemu-server/108.pid  -m 512 -object 'iothread,id=3Diothread=
-virtioscsi0' -object 'iothread,id=3Diothread-virtioscsi1'  -device 'virtio=
-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0' -drive 'file=3D=
disk1.raw,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cache=3Dnone,aio=3Dnative=
,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi0.0,channel=3D0,scsi-=
id=3D0,lun=3D0,drive=3Ddrive-scsi0,id=3Dscsi0' -device 'virtio-scsi-pci,id=
=3Dvirtioscsi1,iothread=3Diothread-virtioscsi1' -drive 'file=3Ddisk2.raw,if=
=3Dnone,id=3Ddrive-scsi1,format=3Draw,cache=3Dnone,aio=3Dnative,detect-zero=
es=3Don' -device 'scsi-hd,bus=3Dvirtioscsi1.0,channel=3D0,scsi-id=3D0,lun=
=3D1,drive=3Ddrive-scsi1,id=3Dscsi1'
>>>
>>> Then open socat to the qmp socket
>>> # socat /var/run/qemu-test.qmp -
>>>
>>> And run the following qmp command:
>>>
>>> { "execute": "qmp_capabilities", "arguments": {} }
>>> { "execute": "transaction", "arguments":  { "actions": [{ "type": "driv=
e-backup", "data": { "device": "drive-scsi0", "sync": "full", "target": "ba=
ckup-sysi0.raw" }}, { "type": "drive-backup", "data": { "device": "drive-sc=
si1", "sync": "full", "target": "backup-scsi1.raw" }}], "properties": { "co=
mpletion-mode": "grouped" } } }
>>>
>>> The VM will core dump:
>>>
>>> qemu: qemu_mutex_unlock_impl: Operation not permitted
>>> Aborted (core dumped)
>>> (gdb) bt
>>> #0  0x00007f099d5037bb in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/unix/sysv/linux/raise.c:50
>>> #1  0x00007f099d4ee535 in __GI_abort () at abort.c:79
>>> #2  0x000055c04e39525e in error_exit (err=3D<optimized out>, msg=3Dmsg@=
entry=3D0x55c04e5122e0 <__func__.16544> "qemu_mutex_unlock_impl") at util/q=
emu-thread-posix.c:36
>>> #3  0x000055c04e395813 in qemu_mutex_unlock_impl (mutex=3Dmutex@entry=
=3D0x7f09903154e0, file=3Dfile@entry=3D0x55c04e51129f "util/async.c", line=
=3Dline@entry=3D601)
>>>     at util/qemu-thread-posix.c:108
>>> #4  0x000055c04e38f8e5 in aio_context_release (ctx=3Dctx@entry=3D0x7f09=
90315480) at util/async.c:601
>>> #5  0x000055c04e299073 in bdrv_set_aio_context_ignore (bs=3D0x7f0929a76=
500, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=3Dignore@entr=
y=3D0x7ffe08fa7400)
>>>     at block.c:6238
>>> #6  0x000055c04e2990cc in bdrv_set_aio_context_ignore (bs=3Dbs@entry=3D=
0x7f092af47900, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=3D=
ignore@entry=3D0x7ffe08fa7400)
>>>     at block.c:6211
>>> #7  0x000055c04e299443 in bdrv_child_try_set_aio_context (bs=3Dbs@entry=
=3D0x7f092af47900, ctx=3D0x7f0990315000, ignore_child=3Dignore_child@entry=
=3D0x0, errp=3Derrp@entry=3D0x0)
>>>     at block.c:6324
>>> #8  0x000055c04e299576 in bdrv_try_set_aio_context (errp=3D0x0, ctx=3D<=
optimized out>, bs=3D0x7f092af47900) at block.c:6333
>>> #9  0x000055c04e299576 in bdrv_replace_child (child=3Dchild@entry=3D0x7=
f09902ef5e0, new_bs=3Dnew_bs@entry=3D0x0) at block.c:2551
>>> #10 0x000055c04e2995ff in bdrv_detach_child (child=3D0x7f09902ef5e0) at=
 block.c:2666
>>> #11 0x000055c04e299ec9 in bdrv_root_unref_child (child=3D<optimized out=
>) at block.c:2677
>>> #12 0x000055c04e29f3fe in block_job_remove_all_bdrv (job=3Djob@entry=3D=
0x7f0927c18800) at blockjob.c:191
>>> #13 0x000055c04e29f429 in block_job_free (job=3D0x7f0927c18800) at bloc=
kjob.c:88
>>> #14 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:359
>>> #15 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:351
>>> #16 0x000055c04e2a0b68 in job_conclude (job=3D0x7f0927c18800) at job.c:=
620
>>> #17 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800) at=
 job.c:688
>>> #18 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800) at=
 job.c:660
>>> #19 0x000055c04e2a14fc in job_txn_apply (txn=3D<optimized out>, fn=3D0x=
55c04e2a0a50 <job_finalize_single>) at job.c:145
>>> #20 0x000055c04e2a14fc in job_do_finalize (job=3D0x7f0927c1c200) at job=
.c:781
>>> #21 0x000055c04e2a1751 in job_completed_txn_success (job=3D0x7f0927c1c2=
00) at job.c:831
>>> #22 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at job.c=
:844
>>> #23 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at job.c=
:835
>>> #24 0x000055c04e2a17b0 in job_exit (opaque=3D0x7f0927c1c200) at job.c:8=
63
>>> #25 0x000055c04e38ee75 in aio_bh_call (bh=3D0x7f098ec52000) at util/asy=
nc.c:164
>>> #26 0x000055c04e38ee75 in aio_bh_poll (ctx=3Dctx@entry=3D0x7f0990315000=
) at util/async.c:164
>>> #27 0x000055c04e3924fe in aio_dispatch (ctx=3D0x7f0990315000) at util/a=
io-posix.c:380
>>> #28 0x000055c04e38ed5e in aio_ctx_dispatch (source=3D<optimized out>, c=
allback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:298
>>> #29 0x00007f099f020f2e in g_main_context_dispatch () at /usr/lib/x86_64=
-linux-gnu/libglib-2.0.so.0
>>> #30 0x000055c04e391768 in glib_pollfds_poll () at util/main-loop.c:219
>>> #31 0x000055c04e391768 in os_host_main_loop_wait (timeout=3D<optimized =
out>) at util/main-loop.c:242
>>> #32 0x000055c04e391768 in main_loop_wait (nonblocking=3Dnonblocking@ent=
ry=3D0) at util/main-loop.c:518
>>> #33 0x000055c04e032329 in qemu_main_loop () at /home/dietmar/pve5-devel=
/mirror_qemu/softmmu/vl.c:1665
>>> #34 0x000055c04df36a8e in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/so=
ftmmu/main.c:49
>=20



--AK5DDXibRtgbCnogsPLrv6j8vo7Rp4QA2--

--MaRd21I1o3MpiOnFjCazTyMzAUUXqthGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl56D38ACgkQ9AfbAGHV
z0CExAf/TVb6Cx8Nrnh+2K3voKwXdNGbGG0paOvbZVEs0ELWEGuWEm8mzCCG0KxJ
NmESehwbquEW+H2zJU1lYq4fcXUpqbcbpkLqEKncJH1fSwZfrzUFOoz4r4LBJtuJ
nij3Axege2LwDX8ubw2az4fuAYDCCkdgIqiFv947thwJ0myASFQXWKQuHf7CaE7u
FVVWG2xvgehjNu6INC9L84xC4vgIqFpCRLGg7by6+UVzGI0iHIMNhiFiGC+WvSh3
8Prok3tDupZ/082eGUyQet5UxRUxSsQ2wXTYIskTH2USDoh9BZbSHMFs+xg/v4pV
gAHLmp0IPyJStGUoE4890ieOmVprQQ==
=UtwH
-----END PGP SIGNATURE-----

--MaRd21I1o3MpiOnFjCazTyMzAUUXqthGE--


