Received: from eggs.gnu.org ([2001:4830:134:3::10]:33369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eL6Mc-0004gG-FK
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 06:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eL6Mb-0001Wh-Jk
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 06:53:46 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171201232433.25193-7-eblake@redhat.com> (Eric Blake's message
	of "Fri, 1 Dec 2017 17:24:32 -0600")
References: <20171201232433.25193-1-eblake@redhat.com>
	<20171201232433.25193-7-eblake@redhat.com>
Reply-To: quintela@redhat.com
Date: Sat, 02 Dec 2017 12:53:28 +0100
Message-ID: <87wp25qrbb.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/7] maint: Fix macros with broken
 'do/while(0); ' usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-trivial@nongnu.org, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

Eric Blake <eblake@redhat.com> wrote:
> The point of writing a macro embedded in a 'do { ... } while (0)'
> loop (particularly if the macro has multiple statements or would
> otherwise end with an 'if' statement) is so that the macro can be
> used as a drop-in statement with the caller supplying the
> trailing ';'.  Although our coding style frowns on brace-less 'if':
>   if (cond)
>     statement;
>   else
>     something else;
> that is the classic case where failure to use do/while(0) wrapping
> would cause the 'else' to pair with any embedded 'if' in the macro
> rather than the intended outer 'if'.  But conversely, if the macro
> includes an embedded ';', then the same brace-less coding style
> would now have two statements, making the 'else' a syntax error
> rather than pairing with the outer 'if'.  Thus, even though our
> coding style with required braces is not impacted, ending a macro
> with ';' makes our code harder to port to projects that use
> brace-less styles.
>
> The change should have no semantic impact.  I was not able to
> fully compile-test all of the changes (as some of them are
> examples of the ugly bit-rotting debug print statements that are
> completely elided by default, and I didn't want to recompile
> with the necessary -D witnesses - cleaning those up is left as a
> bite-sized task for another day); I did, however, audit that for
> all files touched, all callers of the changed macros DID supply
> a trailing ';' at the callsite, and did not appear to be used
> as part of a brace-less conditional.
>
> Found mechanically via: $ git grep -B1 'while (0);' | grep -A1 \\\\
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
