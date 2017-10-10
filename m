Received: from eggs.gnu.org ([2001:4830:134:3::10]:42351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1pCt-0005Qn-AW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1pCq-0007zS-5d
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e1pCp-0007yo-VW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:44:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<877ew4ub3u.fsf@dusky.pond.sub.org>
	<23003.36902.664875.346194@mariner.uk.xensource.com>
Date: Tue, 10 Oct 2017 09:43:56 +0200
In-Reply-To: <23003.36902.664875.346194@mariner.uk.xensource.com> (Ian
	Jackson's message of "Mon, 9 Oct 2017 16:05:10 +0100")
Message-ID: <878tgjla6b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@nongnu.org

Ian Jackson <ian.jackson@eu.citrix.com> writes:

> Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
>> The last thing the QEMU command line needs is more exotic options.  Are
>> you sure we need a new one here?  Can we make existing -runas serve?
>> Precedence: Coreutils[*].  Pseudo-code:
>> 
>>     if argument is a decimal number starting with '+':
>>         user ID
>>     else if argument is a valid user name:
>>         user name
>>     else if argument is a valid user ID:
>>         user ID
>>     else:
>>         error
>
> I can do this.  So -runas <uid>.<gid> then.  I don't think it makes
> sense to try to -runas <uid> because: you wouldn't have a username
> to pass to initgroups: not calling initgroups would be a bear trap;
> and otherwise we wouldn't know what gid to use.

Actually, a numeric UID without group name or ID could be made to work
just fine as long as it maps to a user name.  The use case may not be
worth the bother, though.

Using '.' to separate user and group is suboptimal, because POSIX
portable user and group names may contain it:

    3.426 User Name

    A string that is used to identify a user; see also User Database.
    To be portable across systems conforming to IEEE Std 1003.1-2001,
    the value is composed of characters from the portable filename
    character set.  The hyphen should not be used as the first character
    of a portable user name.

and

    3.276 Portable Filename Character Set

    The set of characters from which portable filenames are constructed.

        A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
        a b c d e f g h i j k l m n o p q r s t u v w x y z
        0 1 2 3 4 5 6 7 8 9 . _ -

http://pubs.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap03.html

Coreutils uses ':'.  Let's follow its lead.
