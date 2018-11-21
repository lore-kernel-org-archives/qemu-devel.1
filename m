Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWcP-0002tm-A3
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWTn-0007UY-Cf
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:40:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPWTn-0007Tt-74
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85C817AE83
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 17:39:58 +0000 (UTC)
References: <20181121131638.26369-1-kraxel@redhat.com>
	<874lca1hnf.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7dea4e0f-ae71-caf6-c637-e1d150b0bcd8@redhat.com>
Date: Wed, 21 Nov 2018 11:39:55 -0600
MIME-Version: 1.0
In-Reply-To: <874lca1hnf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 11/21/18 11:09 AM, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
>> Add query-display-options command, which allows querying the qemu
>> display configuration, and -- as an intentional side effect -- makes
>> DisplayOptions discoverable via query-qmp-schema so libvirt can go
>> figure which display options are supported.
> 
> I understand the why the side effect is useful.  But is it the only
> reason for the new command?

The reason for needing the side effect in 3.1 is because commit d4dc4ab1 
also landed in 3.1; the commit message should really mention that 
relationship.

You are right that in general, a management app should remember what it 
asked for on the command line, and is therefore unlikely to learn 
anything by invoking this command directly.  On the other hand, if the 
display options populate any defaults omitted from the command line, 
this query command might still be useful to show what defaults got 
populated.


>> +DisplayOptions *qmp_query_display_options(Error **errp)
>> +{
>> +    DisplayOptions *opts;
>> +
>> +    opts = g_new(DisplayOptions, 1);
>> +    QAPI_CLONE_MEMBERS(DisplayOptions, opts, &dpy);
>> +    return opts;
> 
> What's wrong with
> 
>         return QAPI_CLONE(DisplayOptions, &dpy)
> 
> ?

Looks like it should work.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
