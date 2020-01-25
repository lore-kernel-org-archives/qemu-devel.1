Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135EDC35241
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 07:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA33F2071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 07:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1hhvpI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA33F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivFl1-0002G4-Vv
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 02:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ivFkO-0001og-MN
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 02:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ivFkM-0002m3-J5
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 02:20:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ivFkM-0002kW-B9
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 02:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579936845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pt5sZzuuToa37LbMwgjCeuiLUTAsmxVYRQwbjkuX1kc=;
 b=W1hhvpI13VkywbnRX7peXXO2/Y6YnAQzlGut/yZ5k0+8C/c592dsTdqhLqrVCms+7Ezdne
 H5O+y7f0NO/TlzPGSFG9OgyLFoXeUeElWo2Xja/KqVw/ATEXGAmiWNbklGEKlAOr0GtYS6
 /wlK4fdxPObxuz5WBv8v0kfqBvHPnDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-AFUqwAsQNAmpJymtjZR_8A-1; Sat, 25 Jan 2020 02:20:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6FCF10120A6
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 07:20:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1066289BC;
 Sat, 25 Jan 2020 07:20:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E80C1138600; Sat, 25 Jan 2020 08:20:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 00/21] Multifd Migration Compression
References: <20200123115831.36842-1-quintela@redhat.com>
Date: Sat, 25 Jan 2020 08:20:40 +0100
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com> (Juan Quintela's
 message of "Thu, 23 Jan 2020 12:58:10 +0100")
Message-ID: <87pnf8ypbr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AFUqwAsQNAmpJymtjZR_8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> [v3]
> - rebased on top of upstream + previous multifd cancel series
> - split multifd code into its own file (multifd.[ch])
> - split zstd/zlib compression methods (multifd-zstd/zlib.c)
> - use qemu module feauture to avoid ifdefs
>   (my understanding is that zlib needs to be present, but
>   we setup zstd only if it is not there or is disabled)
> - multifd-method: none|zlib|zstd
>
>   As far as I can see, there is no easy way to convince qapi that zstd
>   option could/couldn't be there depending on compliation flags. I
>   ended just checking in migrate_parameters_check() if it is enabled
>   and giving an error message otherwise.

Wild guess: this is about PATCH 21's

   diff --git a/qapi/migration.json b/qapi/migration.json
   index 1714ea51e3..65db85970e 100644
   --- a/qapi/migration.json
   +++ b/qapi/migration.json
   @@ -499,7 +499,7 @@
    #
    ##
    { 'enum': 'MultifdCompress',
   -  'data': [ 'none', 'zlib' ] }
   +  'data': [ 'none', 'zlib', 'zstd' ] }

    ##
    # @MigrationParameter:

where you want 'zstd' to be #ifdef CONFIG_ZSTD.  If not, please advise.
Else use something like

    { 'enum': 'MultifdCompress',
      'data': [ 'none', 'zlib',
                { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }

See docs/devel/qapi-code-gen.txt sections "Enumeration types" and
"Configuring the schema".

[...]


