Received: from eggs.gnu.org ([2001:4830:134:3::10]:56139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fqdIk-0001cz-39
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fqdIg-0003Sp-5V
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:52:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fqdIg-0003SH-0H
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:52:18 -0400
Date: Fri, 17 Aug 2018 19:52:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180817115214.GI19773@lemon.usersys.redhat.com>
References: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
Subject: Re: [Qemu-devel] vm-tests images disks filling up?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 08/17 11:26, Peter Maydell wrote:
> I just ran into a build failure using the tests/vm/ BSD build tests,
> because the NetBSD build image's disk filled up.
> 
> Looking more closely there seemed to be 9 stale build trees in
> the VM's /var/tmp/qemu-test.* , which is why the disk was full
> (they'd used up about 18GB between them).
> 
> The other VMs (freebsd, openbsd) also had the same problem of
> /var/tmp gradually filling with stale trees, they just hadn't
> quite run out of space yet...
> 
> What's the process for managing the disk space on these images?
> How are stale or completed build trees deleted ?

Ouch. We used to always use snapshot when running tests until 983c2a777be.

One possibility is to use a fixed temp dir (image locking makes sure no two
tests boot the same image concurrently). I.e. something like:

  $ sed -i -e 's:cd.*mktemp.*:mkdir -p /var/tmp/qemu-vm-test; cd /var/tmp/qemu-vm-test:' tests/vm/*

Fam
