Received: from eggs.gnu.org ([2001:4830:134:3::10]:33687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drYwa-0007Aw-5j
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drYwZ-000474-DI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:20:48 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-19-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b583b7ea-42e3-cf4b-10aa-7cc16f41356e@redhat.com>
Date: Mon, 11 Sep 2017 20:20:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 18/38] ahci-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, armbru@redhat.com, "open list:IDE" <qemu-block@nongnu.org>



On 09/11/2017 01:20 PM, Eric Blake wrote:
> Managing parallel connections to two different monitors via
> the implicit global_qtest makes it hard to copy-and-paste code
> to tests that are not aware of the implicit state; the
> management of global_qtest is even harder to follow because
> it was masked behind set_context().
> 
> Instead, explicitly pass QTestState* around (generally, by
> reusing the member already present in ahci->parent QOSState),
> and call explicit qtest_* functions on all places that
> interact with a monitor.
> 
> We can assert that the conversion is correct by checking that
> global_qtest remains NULL throughout the test (a later patch
> that changes global_qtest to not be a public global variable
> will drop the assertions).
> 
> Bonus: there was one spots that was creating a needless temporary
> variable to execute the 'cont' command, rather than just directly
> passing the literal command through qtest_qmp().  Fixing that
> gets us one step closer to enabling -Wformat checking on
> constructed JSON.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

still LGTM, you can probably still see why I was a little iffy about
making the global qstate ubiquitous instead of doing it this way.

(Though it does make the calls a little more verbose, they are IMO a lot
easier to reason about in tests that deal with mixed-state and
migrations and so on, which -- most of my qtest experience was from AHCI
-- there is a lot of here. (Sorry Markus, I'm a

Reviewed-by: John Snow <jsnow@redhat.com>
