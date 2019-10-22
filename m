Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0F120700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2I77BvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0F120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMv9b-0005rI-4c
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMv8G-0003kr-Dz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMv8C-0003qZ-MA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:27:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMv8C-0003qQ-Gw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571754448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pA834sIkrTm4IwupzEkj25TeoTUp7j2kfZcuyZz6LzQ=;
 b=Y2I77BvXrPk8kBwU330SNDCHINNwjCYp9TqL3+Tlmc76PSTQMm/QXnWbYUZVmJIVcJt2tN
 DMF1pp42FNME8aoqOYtV+Sdp5ES/OOVxfMQnmyEOl/VoAh87hYPbM6C4zG/x/uQ6BobBAq
 Vcw2ru6zYaefin9mxJLF/pkaS1D51Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-3AOeDbFkMqqG1BHGnD5ntA-1; Tue, 22 Oct 2019 10:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E788017D4;
 Tue, 22 Oct 2019 14:27:23 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79B4B5D6B0;
 Tue, 22 Oct 2019 14:27:19 +0000 (UTC)
Date: Tue, 22 Oct 2019 15:27:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
Message-ID: <20191022142717.GG2815@work-vm>
References: <5DAEB9D3.3080503@huawei.com> <20191022085119.GB2815@work-vm>
 <5DAF0FA3.1070309@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5DAF0FA3.1070309@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3AOeDbFkMqqG1BHGnD5ntA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 jiangyiwen <jiangyiwen@huawei.com>, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhenyu Ye (yezhenyu2@huawei.com) wrote:
>=20
>=20
> On 2019/10/22 16:51, Dr. David Alan Gilbert wrote:
> > * yezhenyu (A) (yezhenyu2@huawei.com) wrote:
> >> Since qemu2.9, QEMU added three AioContext poll parameters to struct
> >> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties are
> >> used to control iothread polling time.
> >>
> >> However, there isn't properly hmp commands to adjust them when the VM =
is
> >> alive. It's useful to adjust them online when observing the impact of
> >> different property value on performance.
> >>
> >> This patch add three hmp commands to adjust iothread poll-* properties
> >> for special iothread:
> >>
> >> set_iothread_poll_max_ns: set the maximum polling time in ns;
> >> set_iothread_poll_grow: set how many ns will be added to polling time;
> >> set_iothread_poll_shrink: set how many ns will be removed from polling
> >> time.
> >=20
> > Thanks;  I don't know much about iothread, so I'll answer just from the
> > HMP side.
> >=20
>=20
> Thanks for your review. I will update my patch according to your advice, =
and
> submit a NEW PATCH. Some of my answers are below...
>=20
> >> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> >> ---
> >> hmp-commands.hx | 42 ++++++++++++++++++++
> >> hmp.c | 30 +++++++++++++++
> >> hmp.h | 3 ++
> >> include/sysemu/iothread.h | 6 +++
> >> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
> >> qapi/misc.json | 23 +++++++++++
> >> 6 files changed, 184 insertions(+)
> >>
> >> diff --git a/hmp-commands.hx b/hmp-commands.hx
> >> index a2c3ffc218..6fa0c5227a 100644
> >> --- a/hmp-commands.hx
> >> +++ b/hmp-commands.hx
> >> @@ -74,6 +74,48 @@ VM initialization using configuration data provided=
 on the command line
> >> and via the QMP monitor during the preconfig state. The command is onl=
y
> >> available during the preconfig state (i.e. when the --preconfig comman=
d
> >> line option was in use).
> >> +ETEXI
> >> +
> >> + {
> >> + .name =3D "set_iothread_poll_max_ns",
> >> + .args_type =3D "iothread_id:s,poll_max_ns:i",
> >> + .params =3D "iothread_id poll_max_ns",
> >> + .help =3D "set poll_max_ns for a special iothread",
> >> + .cmd =3D hmp_set_iothread_poll_max_ns,
> >> + },
> >> +
> >> +STEXI
> >> +@item set_iothread_poll_max_ns
> >> +@findex set_iothread_poll_max_ns
> >> +set poll_max_ns property for a special iothread.
> >> +ETEXI
> >> +
> >> + {
> >> + .name =3D "set_iothread_poll_grow",
> >> + .args_type =3D "iothread_id:s,poll_grow:i",
> >> + .params =3D "iothread_id poll_grow",
> >> + .help =3D "set poll_grow for a special iothread",
> >> + .cmd =3D hmp_set_iothread_poll_grow,
> >> + },
> >> +
> >> +STEXI
> >> +@item set_iothread_poll_grow
> >> +@findex set_iothread_poll_grow
> >> +set poll_grow property for a special iothread.
> >> +ETEXI
> >> +
> >> + {
> >> + .name =3D "set_iothread_poll_shrink",
> >> + .args_type =3D "iothread_id:s,poll_shrink:i",
> >> + .params =3D "iothread_id poll_shrink",
> >> + .help =3D "set poll_shrink for a special iothread",
> >> + .cmd =3D hmp_set_iothread_poll_shrink,
> >> + },
> >> +
> >> +STEXI
> >> +@item set_iothread_poll_shrink
> >> +@findex set_iothread_poll_shrink
> >> +set poll_shrink property for a special iothread.
> >> ETEXI
> >=20
> > I think I'd prefer one command with a parameter to select
> > the value to be set;   in migration we used to have lots of commands
> > but are moving to migrate_set_parameter which then handles all of them.
> >=20
> > So something like,
> >=20
> >     iothread set_parameter poll_shrink 10
> >=20
> > The code is a little more complex, but a lot less repetative!
> >=20
>=20
> OK=EF=BC=8C I will combine these in one command such as,
>=20
>     set_iothread_parameter iothread_id parameter_name value

OK, one thing, please use:
   iothread_set_parameter instead of  set_iothread_parameter.

Dave

> >> {
> >> diff --git a/hmp.c b/hmp.c
> >> index 56a3ed7375..87520bcc85 100644
> >> --- a/hmp.c
> >> +++ b/hmp.c
> >> @@ -2711,6 +2711,36 @@ void hmp_info_iothreads(Monitor *mon, const QDi=
ct *qdict)
> >> qapi_free_IOThreadInfoList(info_list);
> >> }
> >>
> >> +void hmp_set_iothread_poll_max_ns(Monitor *mon, const QDict *qdict)
> >> +{
> >> + const char *iothread_id =3D qdict_get_str(qdict, "iothread_id");
> >> + int64_t poll_max_ns =3D qdict_get_int(qdict, "poll_max_ns");
> >> + Error *err =3D NULL;
> >> +
> >> + qmp_set_iothread_poll_param(iothread_id, "poll_max_ns", poll_max_ns,=
 &err);
> >> + hmp_handle_error(mon, &err);
> >> +}
> >> +
> >> +void hmp_set_iothread_poll_grow(Monitor *mon, const QDict *qdict)
> >> +{
> >> + const char *iothread_id =3D qdict_get_str(qdict, "iothread_id");
> >> + int64_t poll_grow =3D qdict_get_int(qdict, "poll_grow");
> >> + Error *err =3D NULL;
> >> +
> >> + qmp_set_iothread_poll_param(iothread_id, "poll_grow", poll_grow, &er=
r);
> >> + hmp_handle_error(mon, &err);
> >> +}
> >> +
> >> +void hmp_set_iothread_poll_shrink(Monitor *mon, const QDict *qdict)
> >> +{
> >> + const char *iothread_id =3D qdict_get_str(qdict, "iothread_id");
> >> + int64_t poll_shrink =3D qdict_get_int(qdict, "poll_shrink");
> >> + Error *err =3D NULL;
> >> +
> >> + qmp_set_iothread_poll_param(iothread_id, "poll_shrink", poll_shrink,=
 &err);
> >> + hmp_handle_error(mon, &err);
> >> +}
> >> +
> >> void hmp_qom_list(Monitor *mon, const QDict *qdict)
> >> {
> >> const char *path =3D qdict_get_try_str(qdict, "path");
> >> diff --git a/hmp.h b/hmp.h
> >> index 43617f2646..8ce3b53556 100644
> >> --- a/hmp.h
> >> +++ b/hmp.h
> >> @@ -41,6 +41,9 @@ void hmp_info_pci(Monitor *mon, const QDict *qdict);
> >> void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
> >> void hmp_info_tpm(Monitor *mon, const QDict *qdict);
> >> void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
> >> +void hmp_set_iothread_poll_max_ns(Monitor *mon, const QDict *qdict);
> >> +void hmp_set_iothread_poll_grow(Monitor *mon, const QDict *qdict);
> >> +void hmp_set_iothread_poll_shrink(Monitor *mon, const QDict *qdict);
> >> void hmp_quit(Monitor *mon, const QDict *qdict);
> >> void hmp_stop(Monitor *mon, const QDict *qdict);
> >> void hmp_sync_profile(Monitor *mon, const QDict *qdict);
> >> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> >> index 5f6240d5cb..7ebeb51f37 100644
> >> --- a/include/sysemu/iothread.h
> >> +++ b/include/sysemu/iothread.h
> >> @@ -45,6 +45,12 @@ char *iothread_get_id(IOThread *iothread);
> >> IOThread *iothread_by_id(const char *id);
> >> AioContext *iothread_get_aio_context(IOThread *iothread);
> >> GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >> +void iothread_set_poll_max_ns(IOThread *iothread, int64_t poll_max_ns=
);
> >> +int64_t iothread_get_poll_max_ns(IOThread *iothread);
> >> +void iothread_set_poll_grow(IOThread *iothread, int64_t poll_grow);
> >> +int64_t iothread_get_poll_grow(IOThread *iothread);
> >> +void iothread_set_poll_shrink(IOThread *iothread, int64_t poll_shrink=
);
> >> +int64_t iothread_get_poll_shrink(IOThread *iothread);
> >>
> >> /*
> >> * Helpers used to allocate iothreads for internal use. These
> >> diff --git a/iothread.c b/iothread.c
> >> index 7130be58e3..4ab6128c5f 100644
> >> --- a/iothread.c
> >> +++ b/iothread.c
> >> @@ -384,3 +384,83 @@ IOThread *iothread_by_id(const char *id)
> >> {
> >> return IOTHREAD(object_resolve_path_type(id, TYPE_IOTHREAD, NULL));
> >> }
> >> +
> >> +void iothread_set_poll_max_ns(IOThread *iothread, int64_t poll_max_ns=
)
> >> +{
> >> + iothread->poll_max_ns =3D poll_max_ns;
> >> +}
> >=20
> > Is the indentation correct here? It looks a bit off.
> >=20
>=20
> I will correct this.
>=20
> >> +int64_t iothread_get_poll_max_ns(IOThread *iothread)
> >> +{
> >> + return iothread->poll_max_ns;
> >> +}
> >> +
> >> +void iothread_set_poll_grow(IOThread *iothread, int64_t poll_grow)
> >> +{
> >> + iothread->poll_grow =3D poll_grow;
> >> +}
> >> +
> >> +int64_t iothread_get_poll_grow(IOThread *iothread)
> >> +{
> >> + return iothread->poll_grow;
> >> +}
> >> +
> >> +void iothread_set_poll_shrink(IOThread *iothread, int64_t poll_shrink=
)
> >> +{
> >> + iothread->poll_shrink =3D poll_shrink;
> >> +}
> >> +
> >> +int64_t iothread_get_poll_shrink(IOThread *iothread)
> >> +{
> >> + return iothread->poll_shrink;
> >> +}
> >> +
> >> +void qmp_set_iothread_poll_param(const char *iothread_id, const char =
*name,
> >> + int64_t value, Error **errp)
> >=20
> > OK, so you should split the patch into a qmp patch and and then an HMP
> > patch.
> > I'll leave the QMP review to others, but I'm guessing they'd prefer
> > to take a QAPI enum here rather than the name.
> >=20
>=20
> I will split the patch according your advice.
>=20
> > Are there some docs somewhere that describe what grow and shrink
> > actually are - are they % ?  If so, then you should range check
> > them to make sure someone doesn't set them to something silly like -5.
> >=20
> >=20
>=20
> They should be positive number. I will add type check in function.
>=20
> >> +{
> >> + Error *local_error =3D NULL;
> >> + int64_t old_value =3D 0;
> >> + IOThread *iothread =3D iothread_by_id(iothread_id);
> >> + if (!iothread) {
> >> + error_setg(errp, "can not find iothread: %s", iothread_id);
> >> + return;
> >> + }
> >> +
> >> + if (strcmp(name, "poll_max_ns") =3D=3D 0) {
> >> + old_value =3D iothread_get_poll_max_ns(iothread);
> >> + iothread_set_poll_max_ns(iothread, value);
> >> + } else if (strcmp(name, "poll_grow") =3D=3D 0) {
> >> + old_value =3D iothread_get_poll_grow(iothread);
> >> + iothread_set_poll_grow(iothread, value);
> >> + } else if (strcmp(name, "poll_shrink") =3D=3D 0) {
> >> + old_value =3D iothread_get_poll_shrink(iothread);
> >> + iothread_set_poll_shrink(iothread, value);
> >> + } else {
> >> + error_setg(errp, "can not find param name: %s", name);
> >> + return;
> >> + }
> >> +
> >> + /* update the value in context */
> >> + aio_context_set_poll_params(iothread->ctx,
> >> + iothread->poll_max_ns,
> >> + iothread->poll_grow,
> >> + iothread->poll_shrink,
> >> + &local_error);
> >> +
> >> + if (local_error) {
> >> + error_propagate(errp, local_error);
> >> +
> >> + /* reset the property to old value */
> >> + if (strcmp(name, "poll_max_ns") =3D=3D 0) {
> >> + iothread_set_poll_max_ns(iothread, old_value);
> >> + } else if (strcmp(name, "poll_grow") =3D=3D 0) {
> >> + iothread_set_poll_grow(iothread, old_value);
> >> + } else if (strcmp(name, "poll_shrink") =3D=3D 0) {
> >> + iothread_set_poll_shrink(iothread, old_value);
> >> + }
> >> +
> >> + return;
> >> + }
> >> +
> >> + return;
> >> +}
> >> diff --git a/qapi/misc.json b/qapi/misc.json
> >> index 8b3ca4fdd3..43d3f4351c 100644
> >> --- a/qapi/misc.json
> >> +++ b/qapi/misc.json
> >> @@ -675,6 +675,29 @@
> >> { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
> >> 'allow-preconfig': true }
> >>
> >> +##
> >> +# @set-iothread-poll-param:
> >> +#
> >> +# Set poll-* properties for a special iothread.
> >> +# The poll-* name can be poll_max_ns/poll_grow/poll_shrink.
> >> +#
> >> +# Notes: can not set the QEMU main loop thread, which is not declared
> >> +# using the -object iothread command-line option. The poll_ns propert=
y can not
> >> +# be set manually, which is auto-adjust.
> >> +#
> >> +# Example:
> >> +#
> >> +# -> { "execute": "set-iothread-poll-param",
> >> +# "arguments": { "iothread_id": "1",
> >> +# "name": "poll_max_ns",
> >> +# "value": 1000 } }
> >> +# <- { "return": {} }
> >> +#
> >> +# Since 3.0
> >=20
> > 3.0 was long long ago; needs updating.
> >=20
>=20
> I will update this to 4.1.0
>=20
> >> +##
> >> +{ 'command': 'set-iothread-poll-param',
> >> + 'data': {'iothread_id': 'str', 'name': 'str', 'value': 'int'} }
> >> +
> >> ##
> >> # @BalloonInfo:
> >> #
> >> --=20
> >> 2.22.0.windows.1
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> >=20
> > .
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


