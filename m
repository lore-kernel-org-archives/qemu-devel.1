Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1csNTT-0003d9-0h
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1csNTQ-0005fC-01
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:45:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1csNTP-0005e0-Lc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:45:47 -0400
References: <1490376002-1223-1-git-send-email-paul.durrant@citrix.com>
	<671b281d-4536-0117-b9a2-b6b72242d3f5@suse.com>
	<alpine.DEB.2.10.1703241153340.8001@sstabellini-ThinkPad-X260>
	<2a218de0a59a4060b00a0f3839323d37@AMSPEX02CL03.citrite.net>
	<4334f125a9174a2e99e5b6f1228da2cd@AMSPEX02CL03.citrite.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <f18632d1-dba1-084d-893c-aca6176754b6@suse.com>
Date: Mon, 27 Mar 2017 07:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <4334f125a9174a2e99e5b6f1228da2cd@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND] xen: limit pkg-config to
 PKG_CONFIG_PATH for xen libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 24/03/17 20:34, Paul Durrant wrote:
>> -----Original Message-----
>> From: Qemu-devel [mailto:qemu-devel-
>> bounces+paul.durrant=citrix.com@nongnu.org] On Behalf Of Paul Durrant
>> Sent: 24 March 2017 19:18
>> To: 'Stefano Stabellini' <sstabellini@kernel.org>; Juergen Gross
>> <jgross@suse.com>
>> Cc: Anthony Perard <anthony.perard@citrix.com>; xen-
>> devel@lists.xenproject.org; qemu-devel@nongnu.org
>> Subject: Re: [Qemu-devel] [PATCH RESEND] xen: limit pkg-config to
>> PKG_CONFIG_PATH for xen libraries
>>
>>> -----Original Message-----
>>> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
>>> Sent: 24 March 2017 19:12
>>> To: Juergen Gross <jgross@suse.com>
>>> Cc: Paul Durrant <Paul.Durrant@citrix.com>; qemu-devel@nongnu.org;
>> xen-
>>> devel@lists.xenproject.org; Anthony Perard
>> <anthony.perard@citrix.com>;
>>> Stefano Stabellini <sstabellini@kernel.org>
>>> Subject: Re: [PATCH RESEND] xen: limit pkg-config to PKG_CONFIG_PATH
>> for
>>> xen libraries
>>>
>>> On Fri, 24 Mar 2017, Juergen Gross wrote:
>>>> On 24/03/17 18:20, Paul Durrant wrote:
>>>>> The Xen tools Makefile has been modified to set PKG_CONFIG_PATH
>>> such that
>>>>> use of pkg-config in QEMU configure finds the newly built Xen libraries.
>>>>> However, because older versions of Xen do not set
>> PKG_CONFIG_PATH
>>> in the
>>>>> Makefile, the QEMU configure script will pick up any Xen libraries that
>>> may
>>>>> be installed in the build system rather than the newly built ones. Thus,
>>>>> if Xen 4.9 is built and installed it becomes impossible to build tools for
>>>>> an older version of Xen on the same system (without manual de-
>>> installtion).
>>>>>
>>>>> This patch modifies configure to set PKG_CONFIG_LIBDIR to empty
>> when
>>>>> looking for Xen libraries to ensure the search is limited only to
>>>>> PKG_CONFIG_PATH. This makes sure that, for versions of Xen prior to
>>> 4.9,
>>>>> pkg-config fails to find the Xen libraries an approriately falls back to
>>>>> previous methods of probing.
>>>>>
>>>>> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>>>
>>> Paul, thanks for spotting this. I didn't spot it because I don't have
>>> Xen installed in my build environment, but we should not rely on that.
>>>
>>>
>>>> NAK. You are breaking normal qemu build with installed Xen pkg-config
>>>> files.
>>>
>>> The normal QEMU build, done as part of the xen-unstable build, is
>>> actually done without Xen being installed in the system. So, if I am not
>>> mistaken, the current mechanism also breaks the following entirely
>>> legitimate scenario:
>>>
>>> - user has 4.9 installed on her system
>>> - user git clones xen 4.10
>>> - user build xen 4.10
>>>   - as part of the xen build, qemu is cloned and built
>>>   - the qemu configure script picks up the pkgconfig file from
>>>     /usr/share and misconfigure the xen version, setting it to 4.9
>>>     instead of 4.10
>>>   - the qemu build fails
>>> - the xen build fails
>>>
>>> Am I right?
>>>
>>
>> I think the above would actually work because the 4.10 files would be found
>> before the 4.9 files. What fails is installing 4.9 and then trying to build 4.8.
> 
> I should qualify that with saying 'trying to build 4.8 with a newer QEMU (i.e. one that has a configure which knows about pkg-config).
> I still think that's a legitimate use-case though.

To sum it up we have to care about the following scenarios:

a) Xen in-tree build, Xen >= 4.9
b) Xen in-tree build, Xen < 4.9
c) build out-of-Xen-tree

combined with any of:

1) no Xen installed on build machine
2) Xen >= 4.9 installed
3) Xen < 4.9 installed

1) + c) is not supported, all other combinations should work.

I suggest the following modifications of my patch:

- keep the test program for detection of Xen 4.9
- scan the extra ldflags for special mentioning of tools/libxc
  to detect Xen in-tree build < 4.9 (will detect 4.9, too, but
  this is no problem), set xen_in_tree_old if found
- if xen_in_tree_old found, don't use pkg-config for Xen version
  detection and flags
- otherwise try pkg-config first

This should cover all cases we need.


Juergen
