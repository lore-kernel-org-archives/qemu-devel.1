Received: from eggs.gnu.org ([209.51.188.92]:53143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggY6L-0002sr-4G
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggY6K-0001Db-A0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:50:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggY6K-0001D5-4i
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:50:08 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-4-fli@suse.com>
Date: Mon, 07 Jan 2019 17:50:05 +0100
In-Reply-To: <20181225140449.15786-4-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:36 +0800")
Message-ID: <878szwo1j6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 03/16] migration: remove unused
 &local_err parameter in multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Fei Li <fli@suse.com> writes:

> Always call migrate_set_error() to set the error state without relying
> on whether multifd_save_cleanup() succeeds.  As the passed &local_err
> is never used in multifd_save_cleanup(), remove it. And make the
> function be: void multifd_save_cleanup(void).
>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

The commit message is confusing.  Suggest:

    migration: multifd_save_cleanup() can't fail, simplify

    multifd_save_cleanup() takes an Error ** argument and returns an
    error code even though it can't actually fail.  Its callers
    dutifully check for failure.  Remove the useless argument and return
    value, and simplify the callers.

I think multifd_load_cleanup() has exactly the same issue.  Should we
clean it up, too?  Juan, what do you think?
