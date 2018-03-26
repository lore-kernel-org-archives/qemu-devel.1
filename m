Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0VOI-000397-5s
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0VOF-0004P3-1E
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0VOE-0004Oj-S6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:54:34 -0400
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
	<9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
	<CAFEAcA8qXbuR+o0h3P5HyGgqLxhn6s9W-jpZp2Cnm-YgSOeNBg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ffb62c2e-58a8-2ed4-f6e4-36921140370c@redhat.com>
Date: Mon, 26 Mar 2018 11:54:27 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qXbuR+o0h3P5HyGgqLxhn6s9W-jpZp2Cnm-YgSOeNBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 03/26/2018 11:12 AM, Peter Maydell wrote:

>> but it would be nice if we can improve our tooling to prevent future
>> instances of the recurring problem.
> 
> Yuck. (Maybe we should try whatever the other workaround for
> this SPF vs mailing lists problem is?)
> 
> If you can suggest a patch to my apply-pullreq script I'm
> happy to change it to reject these at pull application time.
> 
> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/apply-pullreq

My first quick attempt:

diff --git i/apply-pullreq w/apply-pullreq
index a5528e4..9ae4b8f 100755
--- i/apply-pullreq
+++ w/apply-pullreq
@@ -104,6 +104,12 @@ if git diff master..staging | grep -q 'Subproject 
commit'; then
      echo "WARNING: pull appears to include submodule update, please 
check it!"
  fi

+# Check whether any authors needs to be corrected after SPF rewrites
+if git shortlog --author=qemu-devel@nongnu.org master..staging | grep 
.; then
+    echo "ERROR: pull request includes commits attributed to list"
+    exit 1
+fi
+
  # This should exit with an error status if any of the sub-builds fails.
  parallel-buildtest


Hmm, on re-reading that, I wonder if shortlog will do the right thing 
when a .mailmap entry exists.  I'm trying to make sure we don't have to 
go lower-level with use of 'git log --format=%ae' (vs. --format=%aE 
and/or log --use-mailmap).

/me goes and experiments with:

diff --git i/.mailmap w/.mailmap
index cf689b9ec99..a90d7deebe6 100644
--- i/.mailmap
+++ w/.mailmap
@@ -10,6 +10,7 @@ Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl 
<edgar_igl@c046a42c-6fe2-
  Fabrice Bellard <fabrice@bellard.org> bellard 
<bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
  Jocelyn Mayer <l_indien@magic.fr> j_mayer 
<j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
+Julia Suvorova <<jusual@mail.ru> Julia Suvorova via Qemu-devel 
<qemu-devel@nongnu.org>
  Paul Brook <paul@codesourcery.com> pbrook 
<pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
  Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
  Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>

Yay - shortlog still lists Julia's commit even with the mailmap in place 
(but with a better spelling of her name), so I don't need to try 
anything fancier.  I'll post a separate patch for mailmap, then leave it 
up to you whether to incorporate my shortlog snippet above into your 
build script.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
