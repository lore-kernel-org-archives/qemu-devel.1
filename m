Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78FC2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+5uOphk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78FC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv48j-0004sR-TT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iv47s-0004QY-UC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iv47r-0005wI-TI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:56:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44873
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iv47r-0005vb-Pg
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579892174;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Z/TNpnYPpv3qh5mIpFUD7DH+G1b8TqG1N5ERH6UpGo=;
 b=O+5uOphkjdC0StJz238oU42w63IQ3mLvjcHzxXMaBa4RolM0K5qNVZ85OHssouuLt31hU+
 FeaAlXtLVS9BfD3AO6bXETHlUZMd95l74XXA+fxP7CrLFguTHc6FyeBTI8AlFYO3nSdw+I
 KcosAU4dRLrdeb/WzMi5WvLNIN4uEoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-REm8z8FpM1aMh85dOxTfaw-1; Fri, 24 Jan 2020 13:56:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E843107ACC5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 18:56:11 +0000 (UTC)
Received: from redhat.com (ovpn-116-111.ams2.redhat.com [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDF8A5DE53;
 Fri, 24 Jan 2020 18:56:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 16/21] migration: Add support for modules
In-Reply-To: <20200124181322.GY2970@work-vm> (David Alan Gilbert's message of
 "Fri, 24 Jan 2020 18:13:22 +0000")
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-17-quintela@redhat.com>
 <20200124181322.GY2970@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 19:56:08 +0100
Message-ID: <871rro4rav.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: REm8z8FpM1aMh85dOxTfaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> So we don't have to compile everything in, or have ifdefs
>
> Can you explain to me what this is allowing us to do?

See the zstd support.
We don't need to do anything in any other file.  If you compile-in the
multifd-zstd.c code, you have it.  It is to avoid this kind of
constructs:

    if (strstart(uri, "tcp:", &p)) {
        tcp_start_outgoing_migration(s, p, &local_err);
#ifdef CONFIG_RDMA
    } else if (strstart(uri, "rdma:", &p)) {
        rdma_start_outgoing_migration(s, p, &local_err);
#endif
    } else if (strstart(uri, "exec:", &p)) {
        exec_start_outgoing_migration(s, p, &local_err);
    } else if (strstart(uri, "unix:", &p)) {
        unix_start_outgoing_migration(s, p, &local_err);
    } else if (strstart(uri, "fd:", &p)) {
        fd_start_outgoing_migration(s, p, &local_err);
    } else {
        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
                   "a valid migration protocol");
        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                          MIGRATION_STATUS_FAILED);
        block_cleanup_parameters(s);
        return;
    }

This is the following bit that I am going to try, put all the code of
rdma/exec/... in its own file, being able to compile it out and not
having ifdefs left and right.

(In the case of zstd, we still have some code in because I don't know
how to convince qapi of doing:

#ifdef CONFIG_ZSTD
{ 'enum': 'MultiFDMethod',
#ifdef CONFIG_ZSTD
  'data': [ 'none', 'zlib', 'zstd' ] }
#else
  'data': [ 'none', 'zlib' ] }
#endif

If I am told how to fix this, I will change

static MultiFDMethods *multifd_ops[MULTIFD_METHOD__MAX] =3D {
    [MULTIFD_METHOD_NONE] =3D &multifd_nocomp_ops,
};

And remove the last dependency.

Thanks, Juan.


