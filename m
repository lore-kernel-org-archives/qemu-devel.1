Received: from eggs.gnu.org ([2001:4830:134:3::10]:36666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDXDb-0003DZ-3x
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDXDX-0005ca-VZ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:29:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDXDX-0005cR-Py
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:29:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B57876FBA
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 15:29:23 +0000 (UTC)
Date: Tue, 1 May 2018 16:29:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180501152910.GG32129@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524841523-95513-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/11] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com

On Fri, Apr 27, 2018 at 05:05:17PM +0200, Igor Mammedov wrote:
> New option will be used to allow commands, which are prepared/need
> to run, during preconfig state. Other commands that should be able
> to run in preconfig state, should be ameded to not expect machine
> in initialized state or deal with it.
> 
> For compatibility reasons, commands that don't use new flag
> 'allowed-in-preconfig' explicitly are not permitted to run in
> preconfig state but allowed in all other states like they used
> to be.
> 
> Within this patch allow following commands in preconfig state:
>    qmp_capabilities
>    query-qmp-schema
>    query-commands
>    query-command-line-options
>    query-status
>    exit-preconfig
> to allow qmp connection, basic introspection and moving to the next
> state.

Looking at what libvirt sends to QEMU before 'cont', when -S is used,
we have a lot of differences. In order, libvirt does something like
this on guest startup:

"qmp_capabilities"
"query-migrate-capabilities"
"migrate-set-capabilities"
"query-chardev"
"qom-list"
"qom-get"
"qom-get"
"query-hotpluggable-cpus"
"query-cpus"
"query-iothreads"
"balloon"
"query-balloon"
"cont"

So --preconfig looks like it cannot be used for anything libvirt currently
does during guest startup. This would force us to use the new set-numa-node
command right at the start, even though this is possibly not a time when
libvirt is actually ready to set the numa node in QEMU. This kind of code
ordering constraint QEMU will put on libvirt is why I really don't like
the idea of having multiple startup phases where you can only use certain
commands in certain phases.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
