Received: from eggs.gnu.org ([2001:4830:134:3::10]:51286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvL2r-00067S-Mx
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvL2q-0005hN-U5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dvL2q-0005hA-OA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:18:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D89C8806CD
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:18:51 +0000 (UTC)
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
	<20170922101652.GF9243@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4bf59c2a-8b21-0613-5575-3dfee2762633@redhat.com>
Date: Fri, 22 Sep 2017 12:18:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170922101652.GF9243@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 22/09/2017 12:16, Stefan Hajnoczi wrote:
> I suggest adding internal IOThreads alongside user-created IOThreads
> instead of hiding them.  IOThread also needs a bool user_created field
> and a UserCreatableClass->can_be_deleted() function:
> 
>   static bool iothread_can_be_deleted(UserCreatable *uc)
>   {
>       return IOTHREAD(uc)->user_created;
>   }
> 
> This way users cannot delete internal IOThreads.
> 
> But how should object ids be handled?  In theory existing -object
> iothread,id=<id> users could use any name.  How can QEMU generate ids
> for internal IOThreads without conflicting with existing users's ids?

I would add an 'internal' boolean to query-iothreads' response and a new
'show-internal' boolean to the command.  This way, applications that
request internal iothreads would know that the "primary key" is
(internal, id) rather than just the id.

Paolo
