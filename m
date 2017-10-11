Received: from eggs.gnu.org ([2001:4830:134:3::10]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2NFC-00032Y-FY
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 16:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2NF7-0006Gp-Fj
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 16:04:42 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2NF7-0006G0-9A
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 16:04:37 -0400
Received: by mail-wm0-f49.google.com with SMTP id i124so7921421wmf.3
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 13:04:37 -0700 (PDT)
References: <20171010174403.24660-1-martin@schrodt.org>
	<d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
	<d853c85d-d59a-a65c-d672-f6dc6cdd15be@schrodt.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcd43c04-84fa-36f0-ab14-3131a519c9b7@redhat.com>
Date: Wed, 11 Oct 2017 22:04:33 +0200
MIME-Version: 1.0
In-Reply-To: <d853c85d-d59a-a65c-d672-f6dc6cdd15be@schrodt.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schrodt <martin@schrodt.org>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 10/10/2017 20:32, Martin Schrodt wrote:
> These 3 here are only paaudio.c
> 
> - Remove PA reader/writer threads from paaudio.c, and do IO from the
> audio timer directly.
> - Expose new configurable settings, such as TLENGTH and FRAGSIZE, plus
> settings to
>   enable PA_STREAM_ADJUST_LATENCY for input and output device separately.
> - Fix the input delay when first using the input device.
> 
> and cannot really be separated, unfortunately.

Sure they can! :)  This can actually be a good occasion to learn more of
git.  Say you have this large patch in branch qemu-audio-v1, you can now do

   git checkout -b qemu-audio-v2 qemu-audio-v1^
   git checkout qemu-audio-v1 -- .
   git reset

This will create a branch *without* the patch, while putting the files
*with* the patch in your working tree.

Now you can add your changes gradually to the staging area of git (it is
called the "index"):

  git add -p

This command will ask you interactively about staging each separate
hunk, for files that git already tracks.  When done, you can run

  git diff --staged

to show the diff that is staged for commit.  And also

  git diff

to show the diff that is not staged yet.

If you are happy with the staged changes, run:

  git stash --keep-index

and test them.  If there is a problem, fix it.  Then type

  git commit -a -s

to commit the staged changes to your local branch called qemu-audio-v2
(write a good commit message now that the commit is fresh in your mind!).

Now get back to the full changes:

 git checkout qemu-audio-v1 -- .
 git reset

and restart from the "git add -p" step to get the next part of your
patch.  Remember, each single one of your patches must build and runs
(implementing the next logical step in the feature), and at the last
patch, the feature is complete.

Now format the patches as email messages, and send them to the list.
Standing in the root of your QEMU directory, run the following:

git fetch origin
rm -f -- *.patch
git format-patch --cover-letter --subject-prefix="PATCH v2" \
  origin/master..

This command will generate an email file for each one of your commits.
The patch files will be numbered. The file numbered 0000 is a cover
letter, which you should edit in-place:

* in the Subject: line, summarize the goal of your series,

* in the message body, describe the changes on a broad level.

Now it's time to mail-bomb the list.  You have already used git
send-email here so I won't get into further detail.

(Loosely based on
https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt-git-guide-for-edk2-contributors-and-maintainers)

Thanks,

Paolo

> The third one is really only a consequence of the removal of the
> additional audio thread.
