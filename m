Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlAsK-0005TB-Ry
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlAsF-00067C-Qg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dlAsF-00065L-Ji
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:25:55 -0400
Date: Fri, 25 Aug 2017 17:25:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170825092549.GH11465@lemon.lan>
References: <20170822044155.2451-1-famz@redhat.com>
	<8805ba9c-a509-ed81-70e3-16b33bb1135c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8805ba9c-a509-ed81-70e3-16b33bb1135c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Thu, 08/24 11:06, Cleber Rosa wrote:
> I replayed manually the FreeBSD VM setup, just to get a sense of how it
> could be automated.  Taking a few steps back, I realized that:
> 
>  * describing how to prepare a given OS to build QEMU is a generic task,
> not really bound to this VM setup
>  * cloud-init, while unarguably a sound solution, is bound to not only
> VMs, but to already prepared (with cloud-init support) images
> 
> What if we attempt to switch the "build environment setup" automation to
> use a more generic tool such as ansible?  Having an in-tree playbook
> that could be executed against a VM seems like slightly better than
> syncing the WIKI pages.
> 
> I'm no expert in ansible, but I can give it that a try if you fancy the
> idea.
> 

I have no objection if you want to give it a try. However it is basically a
separate problem, and I don't think this series would depend on that. The reason
is that setting up guest ssh is not part of the "build env setup" task, but is
the trickiest part here.  As you can see in the ubuntu image, "cloud-init" is
used just for that, and the build env is simply doing a "apt-get build-dep"; if
it were for Fedora the command is a dnf counterpart.  (I probably could have
removed the dev packages in BSD templates and add code to the *bsd scripts to
locally install packages after downloading.)

Ansible is probably an overkill anyway because what we'd have in the playbooks
are command lists to install package sets. Shell scripts can do that just fine,
this is not what ansible is great for, IMO (of course I'd be wrong if there is
an ansible module called 'build-dep' that supports many OSes, I'm not an ansible
expert either).

Fam
