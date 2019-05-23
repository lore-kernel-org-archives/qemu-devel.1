Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC2CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5EF20675
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YUHTu69m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5EF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTk9w-0003Sz-IA
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 05:37:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hTk96-0003Bd-Hx
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hTk95-0002fo-59
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:36:20 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hTk94-0002d9-HG
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:36:19 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
	[IPv6:2a02:6b8:0:1402::301])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7721F2E0B08;
	Thu, 23 May 2019 12:36:13 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	ZCdohZaU6f-aDkW9uon; Thu, 23 May 2019 12:36:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558604173; bh=W4PVV4CPBJmlhwaOso9iLKILOHF0+pc+0NTgGEEvRMI=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=YUHTu69m3Fxz5zorHusTN4fdVdB5OOqGSLrv6H9vv3tM8BmqhsnnVbKAsiGYDpaTP
	4YnE4XHm8W4+M8xMmwJQUu8BUyM4fugGUGr46c9gmh4uXKBCZtfqgKmQYrWDaHM7RR
	OYgqmIbzCk3svz9/yCtJzzjkknGu7UWfZqnRs5cA=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[2a02:6b8:0:1619::162])
	by dlvcorp1j.mail.yandex.net with LMTP id ToPWQ61FCe-a6dsNQ3j
	for <yury-kotov@yandex-team.ru>; Thu, 23 May 2019 12:36:02 +0300
Received: by vla1-9d3c37294942.qloud-c.yandex.net with HTTP;
	Thu, 23 May 2019 12:36:02 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87r28qjvcq.fsf@dusky.pond.sub.org>
References: <20190514151848.5677-1-yury-kotov@yandex-team.ru>
	<87r28qjvcq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 23 May 2019 12:36:12 +0300
Message-Id: <1269571558604162@vla1-9d3c37294942.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH v2] monitor: Fix fdset_id & fd types for
 corresponding QMP commands
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.05.2019, 19:40, "Markus Armbruster" <armbru@redhat.com>:
> Yury Kotov <yury-kotov@yandex-team.ru> writes:
>
>> =C2=A0Now, fdset_id is int64, but in some places we work with it as in=
t.
>> =C2=A0It seems that there is no sense to use int64 for fdset_id, so it=
's
>> =C2=A0better to fix inconsistency by changing fdset_id type to int and=
 by
>> =C2=A0fixing the reference of corresponding QMP commands: add-fd, remo=
ve-fd,
>> =C2=A0query-fdsets.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0include/monitor/monitor.h | 6 +++---
>> =C2=A0=C2=A0monitor.c | 18 +++++++++---------
>> =C2=A0=C2=A0qapi/misc.json | 10 +++++-----
>> =C2=A0=C2=A0stubs/fdset.c | 4 ++--
>> =C2=A0=C2=A0util/osdep.c | 4 ++--
>> =C2=A0=C2=A0vl.c | 2 +-
>> =C2=A0=C2=A06 files changed, 22 insertions(+), 22 deletions(-)
>>
>> =C2=A0diff --git a/include/monitor/monitor.h b/include/monitor/monitor=
.h
>> =C2=A0index 86656297f1..06f9b6c217 100644
>> =C2=A0--- a/include/monitor/monitor.h
>> =C2=A0+++ b/include/monitor/monitor.h
>> =C2=A0@@ -39,11 +39,11 @@ void monitor_read_command(Monitor *mon, int =
show_prompt);
>> =C2=A0=C2=A0int monitor_read_password(Monitor *mon, ReadLineFunc *read=
line_func,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0void *opaque);
>>
>> =C2=A0-AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int6=
4_t fdset_id,
>> =C2=A0+AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int =
fdset_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool has_opaque,=
 const char *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp);
>> =C2=A0-int monitor_fdset_get_fd(int64_t fdset_id, int flags);
>> =C2=A0-int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
>> =C2=A0+int monitor_fdset_get_fd(int fdset_id, int flags);
>> =C2=A0+int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd);
>> =C2=A0=C2=A0void monitor_fdset_dup_fd_remove(int dup_fd);
>> =C2=A0=C2=A0int monitor_fdset_dup_fd_find(int dup_fd);
>>
>> =C2=A0diff --git a/monitor.c b/monitor.c
>> =C2=A0index bb48997913..b71ce816bc 100644
>> =C2=A0--- a/monitor.c
>> =C2=A0+++ b/monitor.c
>> =C2=A0@@ -160,7 +160,7 @@ struct MonFdsetFd {
>> =C2=A0=C2=A0/* file descriptor set containing fds passed via SCM_RIGHT=
S */
>> =C2=A0=C2=A0typedef struct MonFdset MonFdset;
>> =C2=A0=C2=A0struct MonFdset {
>> =C2=A0- int64_t id;
>> =C2=A0+ int id;
>
> In C, you use int instead of int64_t for fdset IDs.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) fds;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) dup_fds;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_ENTRY(MonFdset) next;
>> =C2=A0@@ -2346,7 +2346,7 @@ static void monitor_fdsets_cleanup(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock(&mon_fdsets_lock=
);
>> =C2=A0=C2=A0}
>>
>> =C2=A0-AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool=
 has_opaque,
>> =C2=A0+AddfdInfo *qmp_add_fd(bool has_fdset_id, int32_t fdset_id, bool=
 has_opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c=
onst char *opaque, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int fd;
>> =C2=A0@@ -2372,7 +2372,7 @@ error:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
>> =C2=A0=C2=A0}
>>
>> =C2=A0-void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, E=
rror **errp)
>> =C2=A0+void qmp_remove_fd(int32_t fdset_id, bool has_fd, int fd, Error=
 **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *mon_fdset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdsetFd *mon_fdset_fd;
>> =C2=A0@@ -2405,10 +2405,10 @@ void qmp_remove_fd(int64_t fdset_id, boo=
l has_fd, int64_t fd, Error **errp)
>> =C2=A0=C2=A0error:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock(&mon_fdsets_lock=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (has_fd) {
>> =C2=A0- snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" =
PRId64,
>> =C2=A0+ snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId32 ", fd:%" =
PRId32,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fdset_id, fd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0- snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64, fdset_id=
);
>> =C2=A0+ snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId32, fdset_id=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, QERR_FD_NOT_FOUND=
, fd_str);
>> =C2=A0=C2=A0}
>> =C2=A0@@ -2454,7 +2454,7 @@ FdsetInfoList *qmp_query_fdsets(Error **er=
rp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fdset_list;
>> =C2=A0=C2=A0}
>>
>> =C2=A0-AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int6=
4_t fdset_id,
>> =C2=A0+AddfdInfo *monitor_fdset_add_fd(int32_t fd, bool has_fdset_id, =
int32_t fdset_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool has_opaque,=
 const char *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0@@ -2476,7 +2476,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bo=
ol has_fdset_id, int64_t fdset_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mon_fdset =3D=3D NULL) {
>> =C2=A0- int64_t fdset_id_prev =3D -1;
>> =C2=A0+ int fdset_id_prev =3D -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *=
mon_fdset_cur =3D QLIST_FIRST(&mon_fdsets);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (has_fd=
set_id) {
>> =C2=A0@@ -2538,7 +2538,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bo=
ol has_fdset_id, int64_t fdset_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fdinfo;
>> =C2=A0=C2=A0}
>>
>> =C2=A0-int monitor_fdset_get_fd(int64_t fdset_id, int flags)
>> =C2=A0+int monitor_fdset_get_fd(int fdset_id, int flags)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0#ifdef _WIN32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOENT;
>> =C2=A0@@ -2576,7 +2576,7 @@ out:
>> =C2=A0=C2=A0#endif
>> =C2=A0=C2=A0}
>>
>> =C2=A0-int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
>> =C2=A0+int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *mon_fdset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdsetFd *mon_fdset_fd_dup;
>> =C2=A0diff --git a/qapi/misc.json b/qapi/misc.json
>> =C2=A0index 8b3ca4fdd3..b345e1458b 100644
>> =C2=A0--- a/qapi/misc.json
>> =C2=A0+++ b/qapi/misc.json
>> =C2=A0@@ -2179,7 +2179,7 @@
>> =C2=A0=C2=A0#
>> =C2=A0=C2=A0# Since: 1.2.0
>> =C2=A0=C2=A0##
>> =C2=A0-{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int', 'fd': 'int=
'} }
>> =C2=A0+{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int32', 'fd': 'i=
nt32'} }
>>
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0# @add-fd:
>> =C2=A0@@ -2209,7 +2209,7 @@
>> =C2=A0=C2=A0#
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0{ 'command': 'add-fd',
>> =C2=A0- 'data': { '*fdset-id': 'int',
>> =C2=A0+ 'data': { '*fdset-id': 'int32',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0'*opaque': 'str' },
>> =C2=A0=C2=A0=C2=A0=C2=A0'returns': 'AddfdInfo' }
>>
>> =C2=A0@@ -2238,7 +2238,7 @@
>> =C2=A0=C2=A0# <- { "return": {} }
>> =C2=A0=C2=A0#
>> =C2=A0=C2=A0##
>> =C2=A0-{ 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'i=
nt'} }
>> =C2=A0+{ 'command': 'remove-fd', 'data': {'fdset-id': 'int32', '*fd': =
'int32'} }
>>
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0# @FdsetFdInfo:
>> =C2=A0@@ -2252,7 +2252,7 @@
>> =C2=A0=C2=A0# Since: 1.2.0
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0{ 'struct': 'FdsetFdInfo',
>> =C2=A0- 'data': {'fd': 'int', '*opaque': 'str'} }
>> =C2=A0+ 'data': {'fd': 'int32', '*opaque': 'str'} }
>>
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0# @FdsetInfo:
>> =C2=A0@@ -2266,7 +2266,7 @@
>> =C2=A0=C2=A0# Since: 1.2.0
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0{ 'struct': 'FdsetInfo',
>> =C2=A0- 'data': {'fdset-id': 'int', 'fds': ['FdsetFdInfo']} }
>> =C2=A0+ 'data': {'fdset-id': 'int32', 'fds': ['FdsetFdInfo']} }
>>
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0# @query-fdsets:
>
> In the schema, you use QAPI type 'int32' instead of 'int'.
>
> Before the patch, the two are consistent (except for the bugs you fixed
> in v1 of this patch): QAPI 'int' is C int64_t.
>
> After the patch, the two are inconsistent: QAPI 'int32' is C int32_t,
> not int. They're usually the same, but it unclean.
>
> Two ways forward:
>
> 1. Revise this patch to use int32_t instead of int.
>
> 2. Revise v1 to address the few minor review comments I had. Smaller
> =C2=A0=C2=A0=C2=A0patch, easier to review.
>
> Your choice. I'd choose 2.
>
> [...]

Sorry, I'm a little confused... I thought method 2 was not ok,
but if it=E2=80=99s not, then I prefer it too.

So, I will send v3 which is v1 with grammar fixes

Regards,
Yury


