Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900EDC4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D0A221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFgD6xKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D0A221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpXe-0003Io-6Z
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMpUw-0000xN-Sk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMpUv-0004OI-4v
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:31:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601285464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjFSxgGPc4uJspVv/nn4QjkKEB+bvI8NQqu3idIZa3k=;
 b=JFgD6xKXr7GVNvlEwE+Wsr4LzoYWFnfPy26LUbdh3P7jsDfTLbNe7XZXyYJaKPUL/fbETw
 jOvhJpFWUp0XNPKlQvdqr40FarRpSjGyMwHghpV2bF/TVmhWkLEgXsIYT43w/7Zf1GS/Ug
 OZMkqc3wRpRuvk8oBTvC3Vb1m0fxqWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-vXZOCL4FPOWoSlps0vhwig-1; Mon, 28 Sep 2020 05:31:01 -0400
X-MC-Unique: vXZOCL4FPOWoSlps0vhwig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139BC1091067;
 Mon, 28 Sep 2020 09:31:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E4FD6715F;
 Mon, 28 Sep 2020 09:30:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24992113865F; Mon, 28 Sep 2020 11:30:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 00/13] monitor: Optionally run handlers in coroutines
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200910132439.GE45048@stefanha-x1.localdomain>
 <20200925171541.GK5731@linux.fritz.box>
Date: Mon, 28 Sep 2020 11:30:55 +0200
In-Reply-To: <20200925171541.GK5731@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 25 Sep 2020 19:15:41 +0200")
Message-ID: <87zh5ajlio.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-block@nongnu.org, armbru@redhat.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org, marcandre.lureau@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.09.2020 um 15:24 hat Stefan Hajnoczi geschrieben:
>> On Wed, Sep 09, 2020 at 05:11:36PM +0200, Kevin Wolf wrote:
>> > Some QMP command handlers can block the main loop for a relatively lon=
g
>> > time, for example because they perform some I/O. This is quite nasty.
>> > Allowing such handlers to run in a coroutine where they can yield (and
>> > therefore release the BQL) while waiting for an event such as I/O
>> > completion solves the problem.
>> >=20
>> > This series adds the infrastructure to allow this and switches
>> > block_resize to run in a coroutine as a first example.
>> >=20
>> > This is an alternative solution to Marc-Andr=C3=A9's "monitor: add
>> > asynchronous command type" series.
>>=20
>> Please clarify the following in the QAPI documentation:
>>  * Is the QMP monitor suspended while the command is pending?
>
> Suspended as in monitor_suspend()? No.

A suspended monitor doesn't read monitor input.

We suspend

* a QMP monitor while the request queue is full

* an HMP monitor while it executes a command

* a multiplexed HMP monitor while the "mux-focus" is elsewhere

* an HMP monitor when it executes command "quit", forever

* an HMP monitor while it executes command "migrate" without -d

Let me explain the first item in a bit more detail.  Before OOB, a QMP
monitor was also suspended while it executed a command.  To make OOB
work, we moved the QMP monitors to an I/O thread and added a request
queue, drained by the main loop.  QMP monitors continue to read
commands, execute right away if OOB, else queue, suspend when queue gets
full, resume when it gets non-full.

The "run command in coroutine context" feature does not affect any of
this.

qapi-code-gen.txt does not talk about monitor suspension at all.  It's
instead discussed in qmp-spec.txt section 2.3.1 Out-of-band execution.

Stefan, what would you like us to clarify, and where?

>>  * Are QMP events reported while the command is pending?
>
> Hm, I don't know to be honest. But I think so.

Yes, events should be reported while a command is being executed.

Sending events takes locks.  Their critical sections are all
short-lived.  Another possible delay is the underlying character device
failing the send with EAGAIN.  That's all.

Fine print: qapi_event_emit() takes @monitor_lock.  It sends to each QMP
monitor with qmp_send_response(), which uses monitor_puts(), which takes
the monitor's @mon_lock.

The "run command in coroutine context" feature does not affect any of
this.

> Does it matter, though? I don't think events have a defined order
> compared to command results, and the client can't respond to the event
> anyway until the current command has completed.

Stefan, what would you like us to clarify, and where?


