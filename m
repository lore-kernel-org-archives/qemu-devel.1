Received: from eggs.gnu.org ([2001:4830:134:3::10]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dknfE-0000kR-PY
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dknf9-0005AH-QP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dknf9-0005A9-JP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D5D680461
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 08:38:49 +0000 (UTC)
Date: Thu, 24 Aug 2017 16:38:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170824083843.GB1866@lemon>
References: <20170824072202.26818-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824072202.26818-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: clean up resources using
 context managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Thu, 08/24 08:21, Stefan Hajnoczi wrote:
> Tests should declare resources upfront in a with statement.  Resources are
> automatically cleaned up whether the test passes or fails:
> 
>   with FilePath('test.img') as img_path,
>        VM() as vm:
>       ...test...
>   # img_path is deleted and vm is shut down automatically

Looks good but still requires test writers to learn and remember to use FilePath
and with.  These are still boilerplates.  Here goes my personal oppinion, so may
not be plausible:

- For VM() maybe add an atexit in the launch() method also makes sure the VM is
  eventually terminated.

  This means vm.shutdown() is still needed in tearDown() if there are multiple
  test methods and each of them expects a clean state, but that is probably
  still less typing (and also indenting) than the with approach, and also easy
  to remember (otherwise a test will fail).

- For scratch how about adding atexit in iotests.main to clean up everything in
  the scratch directory? The rationale is similar to above.

Fam
