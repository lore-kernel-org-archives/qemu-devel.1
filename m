Received: from eggs.gnu.org ([2001:4830:134:3::10]:36166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI2k2-0001Ia-HL
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI2k1-0000hr-O6
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:53:02 -0400
References: <20170605203845.24351-1-eblake@redhat.com>
	<20170605203845.24351-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6b73ec3c-d899-f8f6-20a6-758a4f33acfc@redhat.com>
Date: Mon, 5 Jun 2017 20:52:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170605203845.24351-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com



On 06/05/2017 04:38 PM, Eric Blake wrote:
> Most callback commands in qemu-io return 0 to keep the interpreter
> loop running, or 1 to quit immediately.  However, open_f() just
> passed through the return value of openfile(), which has different
> semantics of returning 0 if a file was opened, or 1 on any failure.
> 
> As a result of mixing the return semantics, we are forcing the
> qemu-io interpreter to exit early on any failures, which is rather
> annoying when some of the failures are obviously trying to give
> the user a hint of how to proceed (if we didn't then kill qemu-io
> out from under the user's feet):
> 
> $ qemu-io
> qemu-io> open foo
> qemu-io> open foo
> file open already, try 'help close'
> $ echo $?
> 0
> 
> In general, we WANT openfile() to report failures, since it is the
> function used in the form 'qemu-io -c "$something" no_such_file'
> for performing one or more -c options on a single file, and it is
> not worth attempting $something if the file itself cannot be opened.
> So the solution is to fix open_f() to always return 0 (when we are
> in interactive mode, even failure to open should not end the
> session), and save the return value of openfile() for command line
> use in main().
> 
> Note, however, that we do have some qemu-iotests that do 'qemu-io
> -c "open file" -c "$something"'; such tests will now proceed to
> attempt $something whether or not the open succeeded, the same way
> as if the two commands had been attempted in interactive mode.  As
> such, the expected output for those tests has to be modified.  But it
> also means that it is now possible to use -c close and have a single
> qemu-io command line operate on more than one file even without
> using interactive mode.  Although the '-c open' action is a subtle
> change in behavior, remember that qemu-io is for debugging purposes,
> so as long as it serves the needs of qemu-iotests while still being
> reasonable for interactive use, it should not be a problem that we
> are changing tests to the new behavior.
> 
> This has been awkward since at least as far back as commit
> e3aff4f, in 2009.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>


Reviewed-by: John Snow <jsnow@redhat.com>
