Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dezSo-0002u2-Er
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dezSn-0004SW-7y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:02:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<f263a454-9dca-ecba-89b8-d09bee6b79ec@redhat.com>
Date: Tue, 08 Aug 2017 10:01:55 +0200
In-Reply-To: <f263a454-9dca-ecba-89b8-d09bee6b79ec@redhat.com> (Cleber Rosa's
	message of "Fri, 21 Jul 2017 09:49:11 -0400")
Message-ID: <87r2wm4he4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Cleber Rosa <crosa@redhat.com> writes:

> On 07/21/2017 08:33 AM, Stefan Hajnoczi wrote:
>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
>>> This is a follow up to a previous discussion about reported failures when
>>> running some qemu-iotests.  Turns out the failures were due to missing
>>> libraries, which in turn, reflected on the host build configuration.
>>>
>>> This series introduces a tool that can check both host and target level
>>> build configurations.  On top of that, it adds a function to to be used
>>> on qemu-iotests.  Finally, as an example, it sets a test to be skipped
>>> if the required feature is not enable on the host build configuration.
>>>
>>> Cleber Rosa (3):
>>>   scripts: introduce buildconf.py
>>>   qemu-iotests: add _require_feature() function
>>>   qemu-iotests: require CONFIG_LINUX_AIO for test 087
>>>
>>>  scripts/buildconf.py         | 278 +++++++++++++++++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/087       |   1 +
>>>  tests/qemu-iotests/check     |   2 +
>>>  tests/qemu-iotests/common.rc |   7 ++
>>>  4 files changed, 288 insertions(+)
>>>
>> 
>> It should be possible to run iotests against any
>> qemu/qemu-img/qemu-io/qemu-nbd binaries - even if no build root is
>> available.
>> 
>
> Yes, I actually overlooked that point.
>
>> How about invoking qemu-img and tools to determine their capabilities?
>> 
>
> Can capabilities be consistently queried?  I would love to not count on
> a build root if the same information can be consistently queried from
> the binaries themselves.
>
>> At the beginning of ./check, query the qemu/qemu-img/qemu-io/qemu-nbd
>> binaries for specific features.  This produces a set of available
>> features and tests can say:
>> 
>
> Which would be another ad-hoc thing, limited to qemu-iotests.  From a
> test writer perspective, QEMU lacks is a uniform way to introspect its
> capabilities.

The closest we have is query-qmp-schema.  It's uniform, but limited to
the qapified part of QMP (see my KVM Forum 2015 talk[*] for details).
Something similar for the command line would be nice, and I hope to get
there some day.  Until then, you can often reason like "if QMP supports
X, then surely the command line supports X'".

We commonly reason "if INTERFACE supports FEATURE-API, then QEMU surely
supports FEATURE".

[...]

[*] https://events.linuxfoundation.org/sites/events/files/slides/armbru-qemu-introspection.pdf
