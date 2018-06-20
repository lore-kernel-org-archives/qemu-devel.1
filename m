Received: from eggs.gnu.org ([2001:4830:134:3::10]:44216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVe6d-00054u-6s
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVe6c-00068E-HH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:29:07 -0400
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-2-berrange@redhat.com>
	<20180620142252.GM2549@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fb1e311-5f1f-51b8-95ca-46ecd92ab4cb@redhat.com>
Date: Wed, 20 Jun 2018 09:28:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180620142252.GM2549@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

On 06/20/2018 09:22 AM, Dr. David Alan Gilbert wrote:

>> For example to setup authorization that only allows connection from a client
>> whose x509 certificate distinguished name is
>>
>>     CN=laptop.example.com,O=Example Org,L=London,ST=London,C=GB
>>
>> use:
>>
>>    qemu-nbd --object tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
>>                      endpoint=server,verify-peer=yes \
>>             --object authz-simple,id=auth0,identity=CN=laptop.example.com,,\
>>                      O=Example Org,,L=London,,ST=London,,C=GB \
> 
> I'm confused about how that gets parsed, what differentiates the ,s
> that separate the arguments (e.g. ,id=  ,identity=) and the ,s that
> separate the options within the identity string (e.g. the ,ST=London)
> Would:
>    --object authz-simple,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB,id=auth0
> 
> be equivalent?

Yes, once you take care of quoting the space and unfolding indentation. 
Our standard QemuOpt parser treats ',,' as a literal comma, and all 
other ',' as separating args.  So either form is ultimately parsed as:

--object
   [type=]"authz-simple"
   id="auth0"
   identity="CN=laptop.example.com,O=Example Org,L=London,ST=London,C=GB"

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
