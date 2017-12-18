Received: from eggs.gnu.org ([2001:4830:134:3::10]:56201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQxyz-0001rz-Va
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQxyy-0006Ro-EY
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:09:37 -0500
Date: Mon, 18 Dec 2017 11:09:28 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1698475524.27734864.1513613368393.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171218135904.GF16653@stefanha-x1.localdomain>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<CAMr-obtBNF8eetFgz=s8vJGqnzGa8+9n4VnF40vZYy5yeFZ3wQ@mail.gmail.com>
	<20171218135904.GF16653@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>


> C code can reuse existing header files for struct definitions instead
> of doing oid, pnm, psn = struct.unpack(">x2s5sxLxxx", data).

On the other hand, C code risks having the same bug in tests and
device models, and also endianness is less apparent in C.  Overall
I'd say it's a wash---if I were to start now I'd use Python but I
agree with you that fragmenting the tests is not a good idea.

For the purpose of testing the SD card code, I'd use the SD-over-SSI
device.  Unfortunately there is no board that uses bit-banging SSI,
but STM32F405 is as close as it can get to it.

Paolo

> In general, Python's model for binary data is a marshalling (copy) model
> rather than a type casting (in-place access) model.  It's fine for some
> things but programs that deal with a lot of raw data may use third-party
> unboxed data primitives like numpy's instead.  I definitely wouldn't say
> that binary I/O is a strength of Python.
> 
> > > and porting this to Python 3 will be extra work later (Python
> > > 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
> > >
> > 
> > You can write today code that work with both python 2 and 3. For binary
> > io the key is using io.FileIO and io.BytesIO instead of open() and StringIO
> > and CStringIO.
> 
> Yes, it's possible to write the code carefully and test under both
> Python 2 & 3.  We have to do that for Python code in QEMU since the
> world is currently transitioning and both Python versions are in use.
> 
> So in this case, where it's questionable to start a new device-level
> testing framework in the first place, the extra trouble of dealing with
> Python 2 & 3 makes it even less appealing.
> 
> Stefan
> 
