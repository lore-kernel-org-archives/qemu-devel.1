Received: from eggs.gnu.org ([2001:4830:134:3::10]:35656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gKoJY-0001O3-Et
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gKoJU-0005Vw-GB
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:41:56 -0500
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
	<8ecdbb0e-aaf8-ddc5-6442-87977585d9d8@redhat.com>
	<87y3a4ot3g.fsf@dusky.pond.sub.org>
	<f69012ad-af21-783c-d378-acd3131451e4@redhat.com>
	<20181108165136.GK12503@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <d8782551-ca89-c70c-a2b9-0ba665171c63@redhat.com>
Date: Thu, 8 Nov 2018 12:36:37 -0500
MIME-Version: 1.0
In-Reply-To: <20181108165136.GK12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 11/8/18 11:51 AM, Eduardo Habkost wrote:

> I'm not sure I agree with the "is an important thing to keep
> track of" part.  I don't think we'll have any need to keep track
> of the Python version in shell script or makefiles after we start
> requiring Python 3.
> 

Well, "Python 3" is not a uniform thing.  There are many changes across
the 3.x spectrum that can bite you.  I'm speaking out of the experience
with Avocado, that supports Python 3.4, 3.5 and 3.6 (and that reminds me
we should add tests for 3.7).

> Extra cleanups (like moving version checks to ./configure) are
> still welcome, but keep in mind that this will probably be thrown
> away once we drop Python 2 support.
> 

I don't think it should.  Let me give the example of a "Python 3.0" job
on Travis, related to the following snippet:

    # Python builds
    - env: CONFIG="--target-list=x86_64-softmmu"
      python:
        - "3.0"

If you look at https://travis-ci.org/clebergnu/qemu/jobs/452033247#L983
you'll see that the intended goal was missed.  That has to do with how
Travis makes the requested Python version available, and it was only
obvious because this branch prints the Python version used.

Developers writing Python code, for instance tests, may assume a given
API that doesn't exist or behave like they expect, and not knowing the
Python version used on a remote environment makes debugging extra hard.

- Cleber.
