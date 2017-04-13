Received: from eggs.gnu.org ([2001:4830:134:3::10]:49905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXs6-00087K-05
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXs2-0002zc-1y
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:04:45 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cyXs1-0002zW-Q7
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:04:41 -0400
Received: by mail-wm0-x230.google.com with SMTP id w64so103493511wma.0
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 23:04:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170406210917.6896-1-eblake@redhat.com>
	<20170407093508.GD26896@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed8d52b1-b897-8a7b-e77c-5dab7dd176c4@redhat.com>
Date: Thu, 13 Apr 2017 14:04:32 +0800
MIME-Version: 1.0
In-Reply-To: <20170407093508.GD26896@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 07/04/2017 17:35, Daniel P. Berrange wrote:
> Is it conceivable that we find a non-signal based way to distinguish
> guest initiated shutdown, from host OS initiated kill when on Win32 ?

As far as I know there's no such thing as a "soft kill" (SIGTERM) on
Win32, since there is no kill function (only raise).

The only interprocess "signals" are Ctrl-C/Ctrl-Break events for the
console, which are mapped to SIGINT or SIGBREAK respectively (the
difference is that the application cannot trap Ctrl-Break, while it can
disable the default Ctrl-C handler).  Likewise there are close-window,
logoff and system shutdown events that the application can trap, but I'm
not sure how much they are worth reporting in the SHUTDOWN event and I'm
also not sure that you get them if you don't have a console, as is the
case for qemu-system-x86_64w.exe.

Paolo

> If so, rather than including a 'signal' field in the event, it might
> be better to just have a 'source': 'host|guest' field. ie we would
> indicate /who/ initiated the shutdown, rather than /how/ it was
> initiated.
