Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6C2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvu31vzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNWde-0000F4-6C
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNWcz-0008Gf-B7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNWcw-0003Zr-Dx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:34:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601451253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wss5RMrLATY2B6ltWuTRpnK1aJj59fsDsuNIDXUMRCs=;
 b=Mvu31vzdi0m3sMKsSEbOd9WZ6ahKOA93AhS+1B0ISgfe73Jj29fv18T4zFIENPhQd5yrll
 Kiv+P79noYL95DjnFwJqAIlRdK0/4u2Ke+eDAfZCM0SwVSo3jqjh+OLk6QfgQLdFnVwY5Z
 hYAoqZ3scMhTdFtHaSDh6G/DGdIcFB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-orSkpVvjMcWZzyVoCrV3uQ-1; Wed, 30 Sep 2020 03:34:10 -0400
X-MC-Unique: orSkpVvjMcWZzyVoCrV3uQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96D1480EFA6;
 Wed, 30 Sep 2020 07:34:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 140AF5D9DC;
 Wed, 30 Sep 2020 07:34:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96457113864A; Wed, 30 Sep 2020 09:34:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
 <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
 <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
 <CAJ+F1CJgEe3++UHDfT3iOGyu+r1tM4A_9jRXoKC0P-k-Mhq29w@mail.gmail.com>
 <fb20f8e4-6bc9-3518-a983-86fad1915e49@redhat.com>
 <CAJ+F1C+p-JLj_epZfLiag7CdJGfZUkFNOmzPTsjCkW=QQ07_3g@mail.gmail.com>
Date: Wed, 30 Sep 2020 09:34:03 +0200
In-Reply-To: <CAJ+F1C+p-JLj_epZfLiag7CdJGfZUkFNOmzPTsjCkW=QQ07_3g@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 29 Sep 2020
 15:34:32 +0400")
Message-ID: <87r1qjhg5w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, 
 Stefan" <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Sep 29, 2020 at 3:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote=
:
[...]
>> Marc-Andr=C3=A9, we are totally in agreement about that!  The problem is=
 that
>> you have already decided what the solution looks like, and that's what
>> I'm not sure about because your solution also implies completely
>> revisiting the schema.
>>
>
> Did I? Which schema change are you (or I) implying? Versioning the
> interface? It's necessary at the client level, unless everything is
> dynamic, after introspection, which makes automated static bindings
> impractical.

I disagree with "necessary".

A client can use a specific version of QMP, and still talk to a server
with a different version, because we designed that capability into QMP.

You absolutely can create bindings for a specific version of QMP for the
client if you want.  Just make sure the client as a whole obeys the
rules of the QMP game laid down in qmp-spec.txt and qapi-code-gen.txt.

>> I say there are many candidates (the ones I know are Protobuf and
>> Flexbuffers) for serialization and many candidates for transport (REST
>> and gRPC to begin with) in addition to the two {QMP,JSON} and
>> {DBus,DBus} tuples.  We should at least look at how they do code
>> generation before deciding that JSON is bad and DBus is good.
>>
>
> Contrary to what you believe I am not focusing so much on DBus here :) It
> took about 200 loc to bind it, effortlessly (compared to sys<->rs
> conversion). All it does is to expose the same API we have in the generat=
ed
> C somehow (similar static types & functions - not all as a{sv} opaque
> dictionaries).

Two points.

1. Opaque dictionaries are far from the only way to do keyword arguments
in a language that lacks them.

2. The API we generate for C is not exactly wonderful.

Behold this beauty:

    void qmp_block_commit(bool has_job_id, const char *job_id, const char *=
device, bool has_base_node, const char *base_node, bool has_base, const cha=
r *base, bool has_top_node, const char *top_node, bool has_top, const char =
*top, bool has_backing_file, const char *backing_file, bool has_speed, int6=
4_t speed, bool has_on_error, BlockdevOnError on_error, bool has_filter_nod=
e_name, const char *filter_node_name, bool has_auto_finalize, bool auto_fin=
alize, bool has_auto_dismiss, bool auto_dismiss, Error **errp);

It's gotten so bad we added a second way to do the C API:

    void qmp_drive_backup(DriveBackup *arg, Error **errp);

Turns out

    DriveBackup arg =3D {
        ... initialize the optionals you need ...
    }
    qmp_drive_backup(&arg, &err);

is a lot easier on the eyes than passing 29 positional arguments.

This could be viewed as a work-around for C's lack of positional
parameters.

Even more fun:

    void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);

BlockdevOptions is a tagged union.

This could be viewed as a work-around for C's lack of function
overloading.

> It's easy for QEMU to generate a good static binding for C, because the
> version always matches. For a client, you wouldn't be able to write a
> similar idiomatic API in C, Rust, Python or Go, unfortunately.

I disagree.  You won't be able to write good bindings using just
positional parameters.  Not even if you add restrictions on how we can
evolve QMP.  And no, I do not consider the C bindings we create for QEMU
itself "good".  They're the best we could do, and good enough.

When you do bindings for another language, do bindings for that
language, not C bindings in that language.

Regardless of bindings, the client as a whole should obey the rules of
the QMP game laid down in qmp-spec.txt and qapi-code-gen.txt.  If these
rules have become counter-productive, then it's time to replace QMP
wholesale.

Do not attempt to force a square peg into a round hole.  If we must have
square pegs, design a square hole, and retire the round hole.

> Iow, I am not trying to sell DBus, I would like to make it easier to bind
> QMP in general. (although I do believe that DBus is a better protocol tha=
n
> QMP for local IPC, yes. And gRPC is probably better for remoting)
>
>> I would rather make those problems solved at the server level, that
>> > doesn't require any change to QMP today, just a more careful
>> > consideration when making changes (and probably some tools to help
>> > enforce some stability).
>>
>> Problem is, "more careful consideration when making changes" is not a
>> small thing.  And other RPCs have evolved in a completely different
>> space (REST APIs for web services) that have chosen the same tradeoffs
>> as QMP, so why should we not learn from them?
>>
>>
> I don't buy that generalization. A very recent protocol in this space, th=
at
> aims to be a good low-level RPC on Linux (for containers, cloud etc) is
> varlink. (In many ways, we could compare it to QMP, but it lacks some
> important features, like events)
>
> varlink does non-optional members and versioning the same way I propose
> here, for what I could tell. Although they use JSON, and have similar
> transport "benefits", this basic rule allow them to have very decent
> automated binding in various languages, without resorting to unorthodox
> solutions, ex:
> https://github.com/varlink/rust/blob/master/examples/example/src/main.rs

Paolo pointed out successful protocols that make tradeoffs similar to
QMP to support the idea that these tradeoffs can make sense and are
workable.

Pointing out other, dissimilar protocols is not a convincing
counter-argument :)


