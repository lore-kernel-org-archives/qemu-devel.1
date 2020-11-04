Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1942C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6E420870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICctFMIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6E420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQmJ-0003RE-O3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaQll-0002zT-0M
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaQlh-0000YA-Te
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604526995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlTdVW9HDQH/hbso+qUVf1GJGcP85xPy8tUCynxOPYk=;
 b=ICctFMIXpPUi85+6ilNXiL/YMXcYepAba5mNT3jK61UESAPEj9ogPURqy8lxILo21M5pL0
 Qwv091RQcg+r3Zag51+TDz6GZitp+L6owsKA3K9jIQwFhwG0/Z9A//4TvuzGqGfBbJGoOT
 QtJY4GGO7YrmjAC6R8pffVVZxYIYwqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-k1kydBkJMXyVgiRKH4hALA-1; Wed, 04 Nov 2020 16:56:22 -0500
X-MC-Unique: k1kydBkJMXyVgiRKH4hALA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901F61882FB1;
 Wed,  4 Nov 2020 21:56:21 +0000 (UTC)
Received: from [10.3.114.103] (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB6FE1A3D6;
 Wed,  4 Nov 2020 21:56:17 +0000 (UTC)
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
References: <20201103024343.894221-1-michael.roth@amd.com>
 <20201103024343.894221-6-michael.roth@amd.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PULL v3 05/12] qga: add command guest-get-disks
Message-ID: <00608db2-f19e-c6b7-a832-9e65fd4c7462@redhat.com>
Date: Wed, 4 Nov 2020 15:56:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103024343.894221-6-michael.roth@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Adding Markus in CC]

On 11/2/20 8:43 PM, Michael Roth wrote:
> From: Tomáš Golembiovský <tgolembi@redhat.com>
> 
> Add API and stubs for new guest-get-disks command.
> 
> The command guest-get-fsinfo can be used to list information about disks
> and partitions but it is limited only to mounted disks with filesystem.
> This new command should allow listing information about disks of the VM
> regardles whether they are mounted or not. This can be usefull for
> management applications for mapping virtualized devices or pass-through
> devices to device names in the guest OS.
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qga/commands-posix.c |  6 ++++++
>  qga/commands-win32.c |  6 ++++++
>  qga/qapi-schema.json | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)

I know my review is late, since the PR is already accepted, but some
items that may be worth followup patches in the 5.2 cycle:


> +++ b/qga/qapi-schema.json
> @@ -865,6 +865,37 @@
>             'bus': 'int', 'target': 'int', 'unit': 'int',
>             '*serial': 'str', '*dev': 'str'} }
>  
> +##
> +# @GuestDiskInfo:
> +#
> +# @name: device node (Linux) or device UNC (Windows)
> +# @partition: whether this is a partition or disk
> +# @dependents: list of dependent devices; e.g. for LVs of the LVM this will
> +#              hold the list of PVs, for LUKS encrypted volume this will
> +#              contain the disk where the volume is placed.     (Linux)

Odd spacing before the comment.

Should @dependents be guarded by 'if', or are we avoiding the use of
'if' in qga for now and only using it in qmp?

Is 'dependents' the right name?  A common English use of 'dependent' is
when talking about a family: a parent's child is their dependent (that
is, a dependent tends to be the smaller entity).  But here, you are
using the term in the opposite direction: this storage device (such as a
LUKS encrypted drive) is declaraing a LARGER entity (the containing
block device) as its dependent.  Would 'dependencies' or 'depends-on' be
more accurate?

> +# @address: disk address information (only for non-virtual devices)
> +# @alias: optional alias assigned to the disk, on Linux this is a name assigned
> +#         by device mapper
> +#
> +# Since 5.2
> +##
> +{ 'struct': 'GuestDiskInfo',
> +  'data': {'name': 'str', 'partition': 'bool', 'dependents': ['str'],
> +           '*address': 'GuestDiskAddress', '*alias': 'str'} }

'dependents' is not an optional member, but documented as '(Linux)'
above; does that mean you always get "dependents":[] on the wire for
Windows, rather than omitting the field?

> +
> +##
> +# @guest-get-disks:
> +#
> +# Returns: The list of disks in the guest. For Windows these are only the
> +#          physical disks. On Linux these are all root block devices of
> +#          non-zero size including e.g. removable devices, loop devices,
> +#          NBD, etc.
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'guest-get-disks',
> +  'returns': ['GuestDiskInfo'] }
> +
>  ##
>  # @GuestFilesystemInfo:
>  #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


