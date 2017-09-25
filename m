Received: from eggs.gnu.org ([2001:4830:134:3::10]:58277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dwPPy-0006AB-PC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dwPPx-0001HY-QM
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:11:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dwPPx-0001Gx-Jd
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:11:09 -0400
References: <1506095371-23160-1-git-send-email-pbonzini@redhat.com>
	<20170925030912.GC22980@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <caf7430e-6819-8c76-5a26-1fcbfc0a0b1a@redhat.com>
Date: Mon, 25 Sep 2017 11:11:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170925030912.GC22980@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] docker: add installation to build tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On 25/09/2017 05:09, Fam Zheng wrote:
> On Fri, 09/22 17:49, Paolo Bonzini wrote:
>> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
>> index 6865689..1522aab 100755
>> --- a/tests/docker/common.rc
>> +++ b/tests/docker/common.rc
>> @@ -36,3 +36,11 @@ build_qemu()
>>      $QEMU_SRC/configure $config_opts
>>      make $MAKEFLAGS
>>  }
>> +
>> +install_qemu()
>> +{
>> +    make install $MAKEFLAGS DESTDIR=$PWD/=destdir
> 
> Why provide DESTDIR? build_qemu already has "--prefix=$INSTALL_DIR", can a
> simple "make install $MAKEFLAGS" work? Is there a permission problem?

Just to test the $DESTDIR case.  I have plans to extend the test a bit
further, such as:

- checking that $INSTALL_DIR remains empty

- comparing the destdir installation against the $INSTALL_DIR (to ensure
that the destdir doesn't end up in the installed files; distro packaging
conventions usually don't like that).

- doing the DESTDIR install as a non-root user

>> +    ret=$?
>> +    rm -rf $PWD/=destdir
> 
> Why is this cleanup needed given the container will go away anyway?

Again it's just for cleanliness.  Another possible test to add is that
"make distclean" actually leaves the build tree in a pristine state, and
this would fail if we leave the installation tree around.

All these tests, by the way, are inspired by the "make distcheck"
produced by Automake.

Paolo
