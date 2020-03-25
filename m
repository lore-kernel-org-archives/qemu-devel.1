Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE87C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9662070A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXL3xYu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9662070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH1Ay-0002c1-5Y
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 04:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1jH1AC-0002Cp-Vx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 04:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1jH1AA-0002ZC-Q1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 04:13:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1jH1AA-0002YV-Kz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 04:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585124001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZNFI9kcrA/0T3PK26F0M1DaktNZznu1aRsrB0+SrP8=;
 b=BXL3xYu/6suoBQ5bhdbmaJVfGXsMd7W2tEgsR7ZDxajDgR0iAFt8IR/oUj/woaHVYbKdE6
 ug2Ie7JmWwg6jJdY1m0LdVsHV7eigdFuMvjxhGG3NNJC5p4QlIeI93cpUkfRdxA/9c1dnY
 HJq9Cy4M/Pciz/2waeCe4GJ8IPIV8nA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-DNTMiHDkP-Slms6HnEDHpw-1; Wed, 25 Mar 2020 04:13:17 -0400
X-MC-Unique: DNTMiHDkP-Slms6HnEDHpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90AB78010EB;
 Wed, 25 Mar 2020 08:13:16 +0000 (UTC)
Received: from localhost (unknown [10.33.36.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E38191293;
 Wed, 25 Mar 2020 08:13:13 +0000 (UTC)
Date: Wed, 25 Mar 2020 09:13:12 +0100
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: backup transaction with io-thread core dumps
Message-ID: <20200325081312.7wtz6crlgotsw5ul@dritchie>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2v3iusiyhsboqlah"
Content-Disposition: inline
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, Dietmar Maurer <dietmar@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2v3iusiyhsboqlah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 02:47:43PM +0100, Max Reitz wrote:
> Hi Dietmar,
>
> I assume this is with master and has popped up only recently?
>
> Maybe it has something to do with the recent mutex patches by Stefan, so
> I=E2=80=99m Cc-ing him.
>

Hi,

I was able to reproduce the issue with a build after the last batch of
AIO fixes and before Stefan's optimizations. This seems to be a new
issue related to { "completion-mode": "grouped" }. Without that
property, the transaction finishes without a crash.

I'm going to take a look at this.

Sergio.

>
> On 24.03.20 14:33, Dietmar Maurer wrote:
> > spoke too soon - the error is still there, sigh
> >
> >> This is fixed with this patch:
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07249.html
> >>
> >> thanks!
> >>
> >>> On March 24, 2020 12:13 PM Dietmar Maurer <dietmar@proxmox.com> wrote=
:
> >>>
> >>>
> >>> I get a core dump with backup transactions when using io-threads.
> >>>
> >>> To reproduce, create and start a VM with:
> >>>
> >>> # qemu-img create disk1.raw 100M
> >>> # qemu-img create disk2.raw 100M
> >>> #./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=3Dqmp,path=
=3D/var/run/qemu-test.qmp,server,nowait' -mon 'chardev=3Dqmp,mode=3Dcontrol=
' -pidfile /var/run/qemu-server/108.pid  -m 512 -object 'iothread,id=3Dioth=
read-virtioscsi0' -object 'iothread,id=3Diothread-virtioscsi1'  -device 'vi=
rtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0' -drive 'fil=
e=3Ddisk1.raw,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cache=3Dnone,aio=3Dna=
tive,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi0.0,channel=3D0,s=
csi-id=3D0,lun=3D0,drive=3Ddrive-scsi0,id=3Dscsi0' -device 'virtio-scsi-pci=
,id=3Dvirtioscsi1,iothread=3Diothread-virtioscsi1' -drive 'file=3Ddisk2.raw=
,if=3Dnone,id=3Ddrive-scsi1,format=3Draw,cache=3Dnone,aio=3Dnative,detect-z=
eroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi1.0,channel=3D0,scsi-id=3D0,lu=
n=3D1,drive=3Ddrive-scsi1,id=3Dscsi1'
> >>>
> >>> Then open socat to the qmp socket
> >>> # socat /var/run/qemu-test.qmp -
> >>>
> >>> And run the following qmp command:
> >>>
> >>> { "execute": "qmp_capabilities", "arguments": {} }
> >>> { "execute": "transaction", "arguments":  { "actions": [{ "type": "dr=
ive-backup", "data": { "device": "drive-scsi0", "sync": "full", "target": "=
backup-sysi0.raw" }}, { "type": "drive-backup", "data": { "device": "drive-=
scsi1", "sync": "full", "target": "backup-scsi1.raw" }}], "properties": { "=
completion-mode": "grouped" } } }
> >>>
> >>> The VM will core dump:
> >>>
> >>> qemu: qemu_mutex_unlock_impl: Operation not permitted
> >>> Aborted (core dumped)
> >>> (gdb) bt
> >>> #0  0x00007f099d5037bb in __GI_raise (sig=3Dsig@entry=3D6) at ../sysd=
eps/unix/sysv/linux/raise.c:50
> >>> #1  0x00007f099d4ee535 in __GI_abort () at abort.c:79
> >>> #2  0x000055c04e39525e in error_exit (err=3D<optimized out>, msg=3Dms=
g@entry=3D0x55c04e5122e0 <__func__.16544> "qemu_mutex_unlock_impl") at util=
/qemu-thread-posix.c:36
> >>> #3  0x000055c04e395813 in qemu_mutex_unlock_impl (mutex=3Dmutex@entry=
=3D0x7f09903154e0, file=3Dfile@entry=3D0x55c04e51129f "util/async.c", line=
=3Dline@entry=3D601)
> >>>     at util/qemu-thread-posix.c:108
> >>> #4  0x000055c04e38f8e5 in aio_context_release (ctx=3Dctx@entry=3D0x7f=
0990315480) at util/async.c:601
> >>> #5  0x000055c04e299073 in bdrv_set_aio_context_ignore (bs=3D0x7f0929a=
76500, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=3Dignore@en=
try=3D0x7ffe08fa7400)
> >>>     at block.c:6238
> >>> #6  0x000055c04e2990cc in bdrv_set_aio_context_ignore (bs=3Dbs@entry=
=3D0x7f092af47900, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=
=3Dignore@entry=3D0x7ffe08fa7400)
> >>>     at block.c:6211
> >>> #7  0x000055c04e299443 in bdrv_child_try_set_aio_context (bs=3Dbs@ent=
ry=3D0x7f092af47900, ctx=3D0x7f0990315000, ignore_child=3Dignore_child@entr=
y=3D0x0, errp=3Derrp@entry=3D0x0)
> >>>     at block.c:6324
> >>> #8  0x000055c04e299576 in bdrv_try_set_aio_context (errp=3D0x0, ctx=
=3D<optimized out>, bs=3D0x7f092af47900) at block.c:6333
> >>> #9  0x000055c04e299576 in bdrv_replace_child (child=3Dchild@entry=3D0=
x7f09902ef5e0, new_bs=3Dnew_bs@entry=3D0x0) at block.c:2551
> >>> #10 0x000055c04e2995ff in bdrv_detach_child (child=3D0x7f09902ef5e0) =
at block.c:2666
> >>> #11 0x000055c04e299ec9 in bdrv_root_unref_child (child=3D<optimized o=
ut>) at block.c:2677
> >>> #12 0x000055c04e29f3fe in block_job_remove_all_bdrv (job=3Djob@entry=
=3D0x7f0927c18800) at blockjob.c:191
> >>> #13 0x000055c04e29f429 in block_job_free (job=3D0x7f0927c18800) at bl=
ockjob.c:88
> >>> #14 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:3=
59
> >>> #15 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:3=
51
> >>> #16 0x000055c04e2a0b68 in job_conclude (job=3D0x7f0927c18800) at job.=
c:620
> >>> #17 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800) =
at job.c:688
> >>> #18 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800) =
at job.c:660
> >>> #19 0x000055c04e2a14fc in job_txn_apply (txn=3D<optimized out>, fn=3D=
0x55c04e2a0a50 <job_finalize_single>) at job.c:145
> >>> #20 0x000055c04e2a14fc in job_do_finalize (job=3D0x7f0927c1c200) at j=
ob.c:781
> >>> #21 0x000055c04e2a1751 in job_completed_txn_success (job=3D0x7f0927c1=
c200) at job.c:831
> >>> #22 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at job=
.c:844
> >>> #23 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at job=
.c:835
> >>> #24 0x000055c04e2a17b0 in job_exit (opaque=3D0x7f0927c1c200) at job.c=
:863
> >>> #25 0x000055c04e38ee75 in aio_bh_call (bh=3D0x7f098ec52000) at util/a=
sync.c:164
> >>> #26 0x000055c04e38ee75 in aio_bh_poll (ctx=3Dctx@entry=3D0x7f09903150=
00) at util/async.c:164
> >>> #27 0x000055c04e3924fe in aio_dispatch (ctx=3D0x7f0990315000) at util=
/aio-posix.c:380
> >>> #28 0x000055c04e38ed5e in aio_ctx_dispatch (source=3D<optimized out>,=
 callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:2=
98
> >>> #29 0x00007f099f020f2e in g_main_context_dispatch () at /usr/lib/x86_=
64-linux-gnu/libglib-2.0.so.0
> >>> #30 0x000055c04e391768 in glib_pollfds_poll () at util/main-loop.c:21=
9
> >>> #31 0x000055c04e391768 in os_host_main_loop_wait (timeout=3D<optimize=
d out>) at util/main-loop.c:242
> >>> #32 0x000055c04e391768 in main_loop_wait (nonblocking=3Dnonblocking@e=
ntry=3D0) at util/main-loop.c:518
> >>> #33 0x000055c04e032329 in qemu_main_loop () at /home/dietmar/pve5-dev=
el/mirror_qemu/softmmu/vl.c:1665
> >>> #34 0x000055c04df36a8e in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu/=
softmmu/main.c:49
> >
>
>

--2v3iusiyhsboqlah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl57EpcACgkQ9GknjS8M
AjV4VQ/9HSELLZdoKMYZb7iYIMcOkqMHsNmk/2yKm2Ky2+pJ+i69jXqnuWiTc3zT
7nrqmMrkr28weKxQ3JvERivaWiMAxMjW+ci7S1Tj+hXMihpv3F45H2Fart/hmqPq
1Tfi6dgb0BGkx0kob4bdPTvtNHgZSd3iqubSp4hvYS42zg/Y8srwrdGtTyDAIpNy
OkKv0n0PvMdyVUZtfhTZ7XFAQCtC6srDd0+G9QTcNoFu6loHRVkmVVIEZNM/3j27
rczkEqDLQ+HuaZ+H0zyWOAGcKOeM4+q3hF0XfmB32rC6h4FEPnnv7FiYrjht9kVJ
hX/d07tg8UTlQMDZ2W45t0aQ+8i5tbhFSjO6QW+sx0ZbGSwxomg0mNltAJDnPwqs
R+Ksf44AbT+dG9GmKsfemT7R58lO9qta5TeeP0DZvIGiMk5eWE56uNQh2aC6Z/e+
0G7jKr8iydDQ+wm94Fnw2IRWhC3R+u8lo+kpo9makJwdXvGSiSmBg8L6gLHGWbe0
7MVG9ae+j3W4heRLuXTX+vAt4o//mtv090eNJDg6FaMFx9vvC1eJlBsUw2bskDm1
x4TfIYrpSRqf9Uqi591AoIpYkkPWpv/hXZZa+EWN4x1kYYYubuUq7N9MAk/9fOea
6zQEo6HQzanCb82hBTqsQBBhWwj1Qgk6cUhP1aS0q00gj9l+GPg=
=of6F
-----END PGP SIGNATURE-----

--2v3iusiyhsboqlah--


