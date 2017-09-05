Received: from eggs.gnu.org ([2001:4830:134:3::10]:53203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBAW-0005p5-9v
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBAR-0001Pi-MM
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:33:20 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-18-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <96c07533-e245-ccee-9632-b80821fad9be@redhat.com>
Date: Tue, 5 Sep 2017 12:32:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-18-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 17/29] ahci-test: Drop dependence on
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
Cc: pbonzini@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com, "open list:IDE" <qemu-block@nongnu.org>

On 01.09.2017 20:03, Eric Blake wrote:
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
> Bonus: there were several spots that were constructing a JSON
> string, then passing that through qmp() as the format, rather
> than directly using qmp() to construct the JSON.  Fixing that
> gets us one step closer to enabling -Wformat checking on
> constructed JSON.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/libqos.h    |  1 -
>  tests/ahci-test.c        | 83 +++++++++++++++++++++++-------------------------
>  tests/libqos/ahci.c      | 45 +++++++++++++-------------
>  tests/libqos/libqos-pc.c |  2 +-
>  tests/libqos/libqos.c    | 37 ++++++---------------
>  5 files changed, 73 insertions(+), 95 deletions(-)

Might be easier to review if you'd split the changes to libqos.c into a
separate patch. But anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
