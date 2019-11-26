Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E052C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4459D20684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzhThFgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4459D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgzn-0003tr-Bi
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZgz8-0003OZ-HB
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZgz6-0005cT-4u
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:58:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZgz6-0005cH-1N
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574798331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNDjSF35xQCdBEcrH7P1Q02oSdr3wCENGtCfgzoNNQg=;
 b=XzhThFgIl5YFATU6FjPyxp40BdbZk+DetSVJaqKmDXKSkj/UaimdEkBGANQ1bvhPPSBrkN
 /+uTh8zbq9DuyYtDiSwnVrAQbIJjB5BZeABjG4OlooFZUzv4lKST3MMh8JeQz/2/Az6jsF
 qiMORI6KWMFFJADpdjqFTPpd4TqPqz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-A0FnS3MYMLixK6N4t_Zsbg-1; Tue, 26 Nov 2019 14:58:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8093F10CE792;
 Tue, 26 Nov 2019 19:58:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46A4660BE2;
 Tue, 26 Nov 2019 19:58:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4F4A1138606; Tue, 26 Nov 2019 20:58:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] block: Error out on image creation with conflicting size
 options
References: <20191126154835.27915-1-kwolf@redhat.com>
 <cf113754-c582-03ae-9e53-ab0213c0ccf9@redhat.com>
 <2e913e12-4819-a729-2179-2b664601087a@redhat.com>
 <20191126162640.GC5889@linux.fritz.box>
 <a42f2815-479c-e74a-3199-8a96c7a145f1@redhat.com>
Date: Tue, 26 Nov 2019 20:58:45 +0100
In-Reply-To: <a42f2815-479c-e74a-3199-8a96c7a145f1@redhat.com> (Eric Blake's
 message of "Tue, 26 Nov 2019 10:39:14 -0600")
Message-ID: <871rtuo1e2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: A0FnS3MYMLixK6N4t_Zsbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 11/26/19 10:26 AM, Kevin Wolf wrote:
>
>>> Actually, your patch fails to diagnose:
>>>
>>> $ qemu-img create -o size=3D1m,size=3D2m -f qcow2 x.qcow2
>>> Formatting 'x.qcow2', fmt=3Dqcow2 size=3D2097152 cluster_size=3D65536
>>> lazy_refcounts=3Doff refcount_bits=3D16
>>>
>>> so you may want to enhance this patch to also catch the case of -o size=
 used
>>> more than once.

Please don't.  Let me explain.

>> Hm... Isn't this something that QemuOpts should already catch? Or do we
>> have callers that actually expect the same option specified multiple
>> times?
>
> QemuOpts is horrible.  It allows duplication, and leaves it up to the
> client what to do about it.  Some clients use the duplication to
> collect multiple arguments (such as specifying more than one cpu),
> some callers treat duplication by honoring only the FIRST option
> specified (and ignoring later uses - I find this ugly), and yet other
> callers treat duplication by honoring only the LAST option specified.

QemuOpts has always permitted multiple keys, last one wins.
key=3D1,key=3D2,key=3D3 means key=3D3.  Permits things like overriding sett=
ings
read from a configuration file on the command line.

The straightforward way to use QemuOpts lets the last one win:
qemu_opt_set() & friends insert at the end of the tail queue,
qemu_opt_find() searches backwards for a match.

Its storing of duplicates may have been just an implementation artifact
initially, but then some "clever" uses were invented.  These work by
iterating over all QemuOpts parameters with qemu_opt_foreach(), or over
all parameters of a certain name with qemu_opt_iter_init() and
qemu_opt_iter_next().

>>
>> Somehow I'm almost sure that Markus will know an example...
>
> Probably of all three (ab)uses of QemuOpt duplication.

What the iterating ones all do is anybody's guess.

A common use is collecting all values.  This presses key repetition into
list service: key=3D1,key=3D2,key=3D3 is interpreted like key: [1, 2, 3].

Abusing iteration to honor the first one instead of the last one would
be disgusting.  I'm not aware of such a user, but I'm also not betting
my own money on absence of such abuse.

Needless to say, the peculiarities of QemuOpts are all ABI by now.
Doesn't mean we cannot change them, only that changes need to be
deliberate and careful.

>> But anyway, I figure the same problem exists for almost all options.

It's a feature, not a problem :)


