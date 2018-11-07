Received: from eggs.gnu.org ([2001:4830:134:3::10]:53207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKQff-0003Ue-Eg
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKQbl-0002oY-NB
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:23:10 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
	<20181107124910.GX12503@habkost.net>
	<CAFEAcA_no6zJ0MG4Af-R0bTi5B9U1M+uArVtJUqkY89iuYgicQ@mail.gmail.com>
	<20181107153422.GY12503@habkost.net>
Date: Wed, 07 Nov 2018 17:22:36 +0100
In-Reply-To: <20181107153422.GY12503@habkost.net> (Eduardo Habkost's message
	of "Wed, 7 Nov 2018 13:34:22 -0200")
Message-ID: <878t24uab7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Fix Python 3 detection
 on older GNU make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Nov 07, 2018 at 01:45:35PM +0000, Peter Maydell wrote:
>> On 7 November 2018 at 12:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > Now, why do we need --with-python, and why do we need to use
>> > $(PYTHON) when running tests?  If somebody wants to use a
>> > different Python binary when running tests, they can already use
>> > $PATH for that.
>> >
>> > (That's the same argument I used for iotests a while ago:
>> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg566631.html)
>> 
>> I'm not a great fan of requiring the user to mess with their PATH
>> to get configure to work. Also, the first python on the path
>> might be the wrong one, and we don't pass PATH from configure
>> to make so you end up having to make sure you specify it
>> right in both places.
>
> You're assuming that this will actually require some people to
> mess with their $PATH because they currently don't have Python on
> their $PATH.  I don't see any evidence that this is expected to
> happen.  Do you?

What makes Python so special we must provide special means to find
it off the PATH?  Why not other tools?

>> Plus we already have --with-python, so if you want to drop
>> it you need to deprecate it first, and you need a justification
>> that's strong enough to outweigh breaking users' existing
>> build/packaging setups and scripts...
>
> I would really like to remove the option as soon as we start
> requiring Python 3.  Let's stop reinventing solutions to problems
> already addressed by PEP 394.

Concur.

We should use python3 wherever we need a Python 3.  There's no point in
letting configure check whether python3 is actually Python 3.

We should use python2 wherever we need a Python 2.  This case needs to
go away (if it isn't gone already).

We may use any of python3, python, python2 wherever we can work with
both Python 3 and 2.  Simply using python3 works on sufficiently recent
hosts.  For maximum portability, we can let configure try python3, then
python.  I wouldn't bother trying python2 as well.
